local neogit = require("plugin_loader").load("neogit")
local buffer_manager_ui = require("plugin_loader").load("buffer_manager.ui")
local oil = require("plugin_loader").load("oil")
local fzf_lua = require("plugin_loader").load("fzf-lua")

---@alias map_table { mode?: string|string[], key: string, cmd: string|function, opts?: vim.keymap.set.Opts }

local M = {}

local exclude = {
	common = {
		[['\.git']], [['\.idea']], [['^\.DS_Store$']],
		[['*.jpg']], [['*.jpeg']], [['*.png']], [['*.gif']],
		[['*.otf']], [['*.ttf']],
	},
	by_filetype = {
		{
			ft = { "dart" },
			path = { [['\.dart_tool']], [[android]], [[ios]], [[build]], },
		},
		{
			ft = { "gd", "gdscript", "gdscript3", "res", "tres", "shader", "godot" },
			path = { [['\.import']], [['\.godot']], [['\.android/build']] },
		},
		{
			ft = { "html", "css", "js", "ts", "tsx", "jsx", "svelte", "vue", "go" },
			path = {
				[[node_modules]], [['prisma/migrations']],
				[['pb_data/storage']], [['pb_data/backups']],
				[['\.svelte-kit']], [['bun.lockb']],
			},
		},
		{
			ft = { "lua" },
			path = { [['mini.nvim']] },
		},
		{
			ft = { "zig", "zon" },
			path = { [['\.zig-cache']] },
		},
		{
			ft = { "ml", "mli", "mlt", "eliom", "eliomi", "opam", "dune", "dune-project", [[\.ocamlformat]] },
			path = { [['_build']] },
		},
	}
}

local function exclude_paths(list)
	local s = ""
	for _, value in ipairs(list) do
		s = s .. [[ -E ]] .. value .. [[ ]]
	end
	return s
end

function M.find_files()
	local cwd = vim.fn.getcwd()
	local ex = exclude_paths(exclude.common)
	local clients = vim.lsp.get_clients()
	if #clients > 0 then
		local client = clients[1]
		if client ~= nil and
			client["config"] ~= nil and
			client["config"]["filetypes"] ~= nil then
			local ft = client["config"]["filetypes"]
			for _, value in ipairs(exclude.by_filetype) do
				local done = false
				for _, filetype in ipairs(value.ft) do
					if vim.tbl_contains(ft, filetype) then
						ex = ex .. exclude_paths(value.path)
						done = true
						break
					end
					if done then break end
				end
			end
		end
	end
	local cmd = [[fd --full-path ]] .. cwd .. [[ --type f -H ]] .. ex
	return cmd
end

function M.fzf_grep_word()
	if fzf_lua == nil then return end
	local mode = vim.api.nvim_get_mode()["mode"]
	if mode ~= nil and type(mode) == "string" and #mode > 0 then
		if string.sub(mode, 0):lower() == "n" then
			vim.api.nvim_input([[viw:lua require("fzf-lua").grep_visual()<CR>]])
		else
			fzf_lua.grep_visual()
		end
	end
end

function M.format_and_save_all_buffers()
	local api, lsp = vim.api, vim.lsp
	local buffers = api.nvim_list_bufs()
	for _, buf in ipairs(buffers) do
		if not api.nvim_buf_is_loaded(buf)
			or not api.nvim_buf_is_valid(buf)
			or not vim.bo[buf].modified then
			goto continue
		end
		local clients = lsp.get_clients({ bufnr = buf })
		if #clients > 0 then
			local client_id = nil
			for _, client in ipairs(clients) do
				if client.attached_buffers[buf] then
					-- NOTE: `supports_method` is not reliable because it is
					-- assumes that the method is supported by the client even
					-- if it doesn't. But it kind of works soooo...
					if client.supports_method("textDocument/formatting", { bufnr = buf })
						or client.supports_method("documentFormattingProvider", { bufnr = buf }) then
						client_id = client.id
						break
					end
				end
			end
			if client_id ~= nil then
				api.nvim_buf_call(buf, function()
					lsp.buf.format({ bufnr = buf, id = client_id })
				end)
			end
		end
		api.nvim_buf_call(buf, function()
			vim.cmd("write")
		end)
		::continue::
	end
end

---Keymap helper.
---"map_table.mode" is "n" by default.
---"map_table.opts" and "opts" are going to be merged. Values from "map_table.opts" will override values from "opts" if any.
---@param map map_table[]
---@param prefix? string
---@param opts? vim.keymap.set.Opts
function M.set_keymap(map, prefix, opts)
	for _, key in ipairs(map) do
		local merged_opts = vim.tbl_deep_extend("keep", key.opts or {}, opts or {})
		local mode = key.mode or "n"
		vim.keymap.set(mode, (prefix or "") .. key.key, key.cmd, merged_opts)
	end
end

---Wrap key in command
---@param key string
---@return string
function M.wrap_in_cmd(key)
	return "<CMD>" .. key .. "<CR>"
end

M.background_color = vim.opt.background

function M.toggle_background_color()
	if M.background_color == "dark" then
		M.background_color = "light"
	else
		M.background_color = "dark"
	end
	vim.opt.background = M.background_color
end

function M.delete_wipe_window(cmd)
	local mode = vim.fn.mode()
	if type(mode) == "string" then
		if (mode == "t" or mode:sub(0, 1) == "n") and vim.o.buftype == "terminal" then
			vim.cmd(cmd .. "!")
		else
			vim.cmd(cmd)
		end
	end
end

function M.open_terminal()
	vim.cmd("split | startinsert | terminal")
end

-- prints selected decimal as hexadecimal
function M.decimal_to_hexadecimal()
	vim.api.nvim_input([[<ESC>:lua vim.print(vim.fn.printf("hexadecimal: %X", <C-R><C-W>))<CR>]])
end

-- buffer manager
function M.toggle_buffer_manager()
	if buffer_manager_ui == nil then return end
	buffer_manager_ui.toggle_quick_menu()
end

-- neogit
function M.open_neogit_window()
	if neogit == nil then return end
	neogit.open({ kind = "split" })
end

-- inlay hints
function M.toggle_inlay_hints()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = nil }))
end

-- oil.nvim
function M.open_oil()
	if oil == nil then return end
	oil.open()
end

function M.open_oil_buffer(opts)
	if oil == nil then return end
	oil.select(opts)
end

function M.close_oil()
	if oil == nil then return end
	oil.close()
end

vim.api.nvim_create_autocmd({ "VimEnter", "SourcePost" }, {
	callback = function()
		M.background_color = vim.o.background
	end,
})

if oil ~= nil then
	---@type vim.keymap.set.Opts
	local oil_opts = { buffer = true }
	---@type map_table[]
	local oil_map = {
		{ key = "<CR>",  cmd = function() M.open_oil_buffer() end, opts = { desc = "open buffer under cursor" } },
		{ key = "<C-c>", cmd = function() M.close_oil() end,       opts = { desc = "close oil" } },
		{ key = "<ESC>", cmd = function() M.close_oil() end,       opts = { desc = "close oil" } },
		{ key = "q",     cmd = function() M.close_oil() end,       opts = { desc = "close oil" } },
	}
	---@type map_table[]
	local oil_remap = {
		{ key = "w", cmd = M.wrap_in_cmd("w"), opts = { desc = [[override global "save all buffers" to save only oil buffer]] } }
	}

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "oil",
		callback = function()
			M.set_keymap(oil_map, nil, oil_opts)
			M.set_keymap(oil_remap, "<leader>", oil_opts)
		end,
	})
end

return M
