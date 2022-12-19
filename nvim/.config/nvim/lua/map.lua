local M = {}

-- leader key
vim.g.mapleader = " "

local options = {
	noremap = true,
	silent = true,
}

M.background_color = "dark"

function M.toggle_background_color()
	if M.background_color == "dark" then
		M.background_color = "light"
		print(" + light is on +")
	else
		M.background_color = "dark"
		print(" - light is off -")
	end
	vim.opt.background = M.background_color
end

-- Global
local global_map = {
	{ key = "<Tab>", cmd = "bn" }, -- next buffer
	{ key = "<S-Tab>", cmd = "bp" }, -- prev buffer
	{ key = "<leader>w", cmd = "w" }, -- write buffer
	{ key = "<leader>bd", cmd = "bd" }, -- delete buffer
	{ key = "<leader>bw", cmd = "bw" }, -- wipe buffer
	{ key = "<leader>bm", cmd = function() return require("buffer_manager.ui").toggle_quick_menu() end }, -- open buffer manager
	{ key = "<leader>gn", cmd = "Explore" }, -- open netrw
	{ key = "<leader>cn", cmd = "cn" }, -- next entry point form the quicklist
	{ key = "<leader>cp", cmd = "cp" }, -- prew entry point form the quicklist
	{ key = "<leader>gr", cmd = "so %" }, -- source nvim config
	{ key = "<leader>bb", cmd = function() return require('map').toggle_background_color() end }, -- toggle background color

	{ key = "<leader>gg", cmd = "lua require('plugins.neogit').open()" }, -- neogit
}

for _, key in ipairs(global_map) do
	if type(key.cmd) == "function" then
		vim.keymap.set("n", key.key, key.cmd, options)
	else
		vim.keymap.set("n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
	end
	vim.keymap.set("i", "<C-c>", "<Esc>", options)
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

local lsp_prefix = "<leader>s"

function M.set_lsp_map(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	local lsp_map = {
		{ key = "h", cmd = function() return vim.lsp.buf.hover() end },
		{ key = "r", cmd = function() return vim.lsp.buf.rename() end },
		{ key = "g", cmd = function() return vim.lsp.buf.declaration() end },
		{ key = "d", cmd = function() return vim.lsp.buf.definition() end },
		{ key = "i", cmd = function() return vim.lsp.buf.implementation() end },
		{ key = "c", cmd = function() return vim.lsp.buf.references() end },
		{ key = "f", cmd = function() return vim.lsp.buf.format({
				async = true
			})
		end },
		{ key = "e", cmd = function() return vim.lsp.buf.signature_help() end },
		{ key = "s", cmd = function() return vim.diagnostic.open_float() end },
		{ key = "p", cmd = function() return vim.diagnostic.goto_prev() end },
		{ key = "n", cmd = function() return vim.diagnostic.goto_next() end },
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
	{ key = "f", cmd = function() return require("telescope.builtin").find_files(
		{
			hidden = true,
			no_ignore = true,
		}
	) end },
	{ key = "t", cmd = function() return require("telescope.builtin").treesitter(
		{
			symbol_highlights = symbol_highlights,
		}
	) end },
	{ key = "s", cmd = function() return require("telescope.builtin").lsp_document_symbols(
		{
			symbol_highlights = symbol_highlights,
		}
	) end },
	{ key = "c", cmd = function() return require("telescope.builtin").current_buffer_fuzzy_find() end },
	{ key = "h", cmd = function() return require("telescope.builtin").command_history() end },
	{ key = "b", cmd = function() return require("telescope.builtin").buffers(
		{
			show_all_buffers = true,
			ignore_current_buffer = false,
			sort_lastused = true,
			sort_mru = true
		}
	) end },
	{ key = "r", cmd = function() return require("telescope.builtin").registers() end },
}

for _, key in ipairs(telescope_map) do
	vim.keymap.set("n", telescope_prefix .. key.key, key.cmd, options)
end

-- Packer
local packer_prefix = "<leader>p"
local packer_map = {
	{ key = "s", cmd = "PackerSync" }
}

for _, key in ipairs(packer_map) do
	vim.keymap.set("n", packer_prefix .. key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

vim.api.nvim_create_autocmd({
	"VimEnter",
	"SourcePost",
}, {
	callback = function()
		M.background_color = vim.o.background
	end,
})

return M
