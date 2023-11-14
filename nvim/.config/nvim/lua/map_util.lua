local neogit = require("neogit")
local buffer_manager_ui = require("buffer_manager.ui")
local oil = require("oil")

local M = {}

local exclude = {
	common = {
		[[\.git]], [[\.idea]],
	},
	by_filetype = {
		{
			ft = { "dart" },
			path = { [[\.dart_tool]], "android", "ios", "build", },
		},
		{
			ft = { "go" },
			path = { "media", },
		},
		{
			ft = { "gd", "gdscript", "gdscript3", "res", "tres", "shader", "godot" },
			path = { [[\.import]], [[\.godot]], [[\.android/build]] },
		},
		{
			ft = { "js", "ts" },
			path = { "node_modules", "prisma/migrations" },
		},
		{
			ft = { "lua" },
			path = { "mini.nvim" },
		},
	}
}

local function concat_find_path(list, cwd)
	local s = ""
	for i, value in ipairs(list) do
		if i == 1 then
			s = s .. [[ -path ']] .. cwd .. [[/]] .. value .. [[/*' ]]
		else
			s = s .. [[ -o -path ']] .. cwd .. [[/]] .. value .. [[/*' ]]
		end
	end
	return s
end

function M.find_files()
	local cwd = vim.fn.getcwd()
	local ex = concat_find_path(exclude.common, cwd)
	local clients = vim.lsp.get_active_clients()
	if clients ~= nil and #clients > 0 then
		local client = clients[1]
		if client ~= nil and
			client["config"] ~= nil and
			client["config"]["filetypes"] ~= nil then
			local ft = client["config"]["filetypes"]
			for _, value in ipairs(exclude.by_filetype) do
				local done = false
				for _, filetype in ipairs(value.ft) do
					if vim.tbl_contains(ft, filetype) then
						ex = ex .. " -o " .. concat_find_path(value.path, cwd)
						done = true
						break
					end
					if done then break end
				end
			end
		end
	end
	local cmd = [[find ]] .. cwd .. [[ -type f -not \(]] .. ex .. [[\)]]
	return cmd
end

function M.fzf_grep_word()
	local mode = vim.api.nvim_get_mode()["mode"]
	if mode ~= nil and type(mode) == "string" and #mode > 0 then
		if string.sub(mode, 0):lower() == "n" then
			vim.api.nvim_input([[viw:lua require("fzf-lua").grep_visual()<CR>]])
		else
			require("fzf-lua").grep_visual()
		end
	end
end

-- keymap helper
function M.set_keymap(map, prefix, opts)
	for _, key in ipairs(map) do
		if type(key.cmd) == "function" then
			vim.keymap.set("n", prefix .. key.key, key.cmd, opts)
		else
			vim.keymap.set("n", prefix .. key.key, "<Cmd>" .. key.cmd .. "<CR>", opts)
		end
	end
end

M.background_color = vim.opt.background

function M.toggle_background_color()
	if M.background_color == "dark" then
		M.background_color = "light"
		print(" lights on +")
	else
		M.background_color = "dark"
		print(" lights off -")
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

-- buffer manager
function M.toggle_buffer_manager()
	buffer_manager_ui.toggle_quick_menu()
end

-- neogit
function M.open_neogit_window()
	neogit.open({ kind = "split" })
end

-- oil.nvim
function M.open_oil()
	oil.open()
end

function M.open_oil_buffer(opts)
	oil.select(opts)
end

function M.close_oil()
	oil.close()
end

vim.api.nvim_create_autocmd({ "VimEnter", "SourcePost" }, {
	callback = function()
		M.background_color = vim.o.background
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function(args)
		if args.match == "oil" then
			vim.keymap.set("n", "<CR>", function() M.open_oil_buffer(nil) end, { buffer = true })
			vim.keymap.set("n", "<C-c>", function() M.close_oil() end, { buffer = true })
			vim.keymap.set("n", "<Esc>", function() M.close_oil() end, { buffer = true })
			vim.keymap.set("n", "q", function() M.close_oil() end, { buffer = true })
		end
	end,
})

return M
