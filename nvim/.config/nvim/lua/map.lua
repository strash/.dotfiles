local M = {}

local neogit = require("neogit")
local buffer_manager_ui = require("buffer_manager.ui")
local oil = require("oil")

-- leader key
vim.g.mapleader = " "

local options = {
	noremap = true,
	silent = true,
}

M.background_color = vim.opt.background
M.last_opened_dir = "."

local toggle_background_color = function()
	if M.background_color == "dark" then
		M.background_color = "light"
		print(" lights on +")
	else
		M.background_color = "dark"
		print(" lights off -")
	end
	vim.opt.background = M.background_color
end

local delete_wipe_window = function(cmd)
	local mode = vim.fn.mode()
	if type(mode) == "string" then
		if (mode == "t" or mode:sub(0, 1) == "n") and vim.o.buftype == "terminal" then
			vim.cmd(cmd .. "!")
		else
			vim.cmd(cmd)
		end
	end
end

local open_terminal = function()
	vim.cmd("split | startinsert | terminal")
end

local grep_word_under_cursor = function()
	local filetype = string.match(vim.api.nvim_buf_get_name(0), "%.%w*$") or vim.o.filetype
	if filetype then
		vim.api.nvim_input([[:vim <C-R><C-W> **/*]] .. filetype .. [[<CR>:cope<CR>]])
	else
		vim.notify("Filetype is nil. Can't grep that shit.", vim.log.levels.ERROR, {})
	end
end

-- buffer manager
local toggle_buffer_manager = function()
	buffer_manager_ui.toggle_quick_menu()
end

-- neogit
local open_neogit_window = function()
	neogit.open()
end

-- oil.nvim
local open_oil = function()
	oil.open(M.last_opened_dir)
end

local open_oil_buffer = function(opts)
	M.last_opened_dir = oil.get_current_dir()
	oil.save({ confirm = false })
	oil.select(opts)
end

local close_oil = function()
	M.last_opened_dir = oil.get_current_dir()
	oil.save({ confirm = false })
	oil.close()
end

-- Global
local global_map = {
	{ key = "<Tab>",      cmd = "bn" },                                  -- next buffer
	{ key = "<S-Tab>",    cmd = "bp" },                                  -- prev buffer
	{ key = "<leader>w",  cmd = "wa" },                                  -- write all buffers
	{ key = "<leader>bd", cmd = function() delete_wipe_window("bd") end }, -- delete buffer
	{ key = "<leader>bw", cmd = function() delete_wipe_window("bw") end }, -- wipe buffer
	{ key = "<leader>bm", cmd = function() toggle_buffer_manager() end }, -- open buffer manager
	--{ key = "<leader>gn", cmd = "Explore" },                             -- open netrw
	{ key = "<leader>gn", cmd = function() open_oil() end },             -- open oil
	{ key = "<leader>cc", cmd = "cc" },                                  -- open first error
	{ key = "<leader>cn", cmd = "cn" },                                  -- next entry point form the quicklist
	{ key = "<leader>cp", cmd = "cp" },                                  -- prew entry point form the quicklist
	{ key = "<leader>gr", cmd = "so %" },                                -- source nvim config
	{ key = "<leader>gt", cmd = function() open_terminal() end },        -- open terminal window
	{ key = "<leader>bb", cmd = function() toggle_background_color() end }, -- toggle background color
	{ key = "<leader>gg", cmd = function() open_neogit_window() end },   -- open neogit
}

for _, key in ipairs(global_map) do
	if type(key.cmd) == "function" then
		vim.keymap.set("n", key.key, key.cmd, options)
	else
		vim.keymap.set("n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
	end
	vim.keymap.set("i", "<C-C>", "<Esc>", options)                                           -- exit enstert mode
	vim.keymap.set("t", "<C-Esc>", [[<C-\><C-N>]], options)                                  -- exit insert mode in terminal
	vim.keymap.set({ "n", "v" }, "<leader>f", function() grep_word_under_cursor() end, options) -- grep word under cursor
end

-- LSP
local opt = {
	relative = "cursor",
	max_width = 120,
	wrap = true,
	wrap_at = 118,
	pad_top = 0,
	pad_bottom = 0,
	style = "minimal",
	border = "rounded",
	focusable = true,
	focus = true,
	noautocmd = true,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, opt
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help, opt
)

local lsp_prefix = "<leader>s"

function M.set_lsp_map(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	local lsp_map = {
		{ key = "h", cmd = function() vim.lsp.buf.hover() end },
		{ key = "r", cmd = function() vim.lsp.buf.rename() end },
		{ key = "g", cmd = function() vim.lsp.buf.declaration() end },
		{ key = "d", cmd = function() vim.lsp.buf.definition() end },
		{ key = "i", cmd = function() vim.lsp.buf.implementation() end },
		{ key = "c", cmd = function() vim.lsp.buf.references() end },
		{ key = "f", cmd = function() vim.lsp.buf.format() end },
		{ key = "e", cmd = function() vim.lsp.buf.signature_help() end },
		{ key = "s", cmd = function() vim.diagnostic.open_float() end },
		{ key = "p", cmd = function() vim.diagnostic.goto_prev() end },
		{ key = "n", cmd = function() vim.diagnostic.goto_next() end },
		{ key = "q", cmd = function() vim.diagnostic.setqflist() end },
	}

	for _, key in ipairs(lsp_map) do
		vim.keymap.set("n", lsp_prefix .. key.key, key.cmd, opts)
	end
	vim.keymap.set({ "n", "v" }, lsp_prefix .. "a", vim.lsp.buf.code_action, opts)

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Telescope
local telescope_prefix = "<leader>t"
local symbol_highlights = {
	["string"] = "String",
	["function"] = "Function",
	["var"] = "@variable",
	["associated"] = "Constant",
	["parameter"] = "@attribute",
}

local telescope_map = {
	{
		key = "f",
		cmd = function()
			require("telescope.builtin").find_files({ hidden = true, no_ignore = true, })
		end
	},
	{
		key = "t",
		cmd = function()
			require("telescope.builtin").treesitter({ symbol_highlights = symbol_highlights, })
		end
	},
	{
		key = "s",
		cmd = function()
			return require("telescope.builtin").lsp_document_symbols({ symbol_highlights = symbol_highlights, })
		end
	},
	{ key = "c", cmd = function() require("telescope.builtin").current_buffer_fuzzy_find() end },
	{ key = "h", cmd = function() require("telescope.builtin").command_history() end },
	{
		key = "b",
		cmd = function()
			require("telescope.builtin").buffers(
				{
					show_all_buffers = true,
					ignore_current_buffer = false,
					sort_lastused = true,
					sort_mru = true
				}
			)
		end
	},
	{ key = "r", cmd = function() require("telescope.builtin").registers() end },
}

for _, key in ipairs(telescope_map) do
	vim.keymap.set("n", telescope_prefix .. key.key, key.cmd, options)
end

-- Package manager
local packer_prefix = "<leader>p"
local packer_map = {
	{ key = "s", cmd = "PackerSync" }
}

for _, key in ipairs(packer_map) do
	vim.keymap.set("n", packer_prefix .. key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

vim.api.nvim_create_autocmd({ "VimEnter", "SourcePost" }, {
	callback = function()
		M.background_color = vim.o.background
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function(args)
		if args.match == "oil" then
			vim.keymap.set("n", "<CR>", function() open_oil_buffer(nil) end, { buffer = true })
			vim.keymap.set("n", "<C-v>", function() open_oil_buffer({ vertical = true, }) end, { buffer = true })
			vim.keymap.set("n", "<C-s>", function() open_oil_buffer({ horizontal = true, }) end, { buffer = true })
			vim.keymap.set("n", "<C-c>", function() close_oil() end, { buffer = true })
			vim.keymap.set("n", "<Esc>", function() close_oil() end, { buffer = true })
			vim.keymap.set("n", "q", function() close_oil() end, { buffer = true })
		end
	end,
})

return M
