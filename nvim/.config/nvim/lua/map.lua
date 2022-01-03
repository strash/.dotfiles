local MAP = {}
local api = vim.api

-- leader key
vim.g.mapleader = " "

local options = {
	noremap = true,
	silent = true,
}

-- Global
local global_map = {
	{ key = "<Tab>",     cmd = "bn" },
	{ key = "<S-Tab>",   cmd = "bp" },
	{ key = "<leader>w", cmd = "bw" },
	{ key = "<leader>l", cmd = "ls!" },
	{ key = "<leader>n", cmd = "Explore" },
}

for _, key in ipairs(global_map) do
	api.nvim_set_keymap("n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end


-- LSP
local lsp_prefix = "s"
function MAP.set_lsp_map(_, bufnr)

	local lsp_map = {
		{ key = "<leader>" .. lsp_prefix .. "h", cmd = "lua vim.lsp.buf.hover()" },
		{ key = "<leader>" .. lsp_prefix .. "r", cmd = "lua vim.lsp.buf.rename()" },
		{ key = "<leader>" .. lsp_prefix .. "a", cmd = "lua vim.lsp.buf.code_action()" },
		{ key = "<leader>" .. lsp_prefix .. "g", cmd = "lua vim.lsp.buf.declaration()" },
		{ key = "<leader>" .. lsp_prefix .. "d", cmd = "lua vim.lsp.buf.definition()" },
		{ key = "<leader>" .. lsp_prefix .. "i", cmd = "lua vim.lsp.buf.implementation()" },
		{ key = "<leader>" .. lsp_prefix .. "f", cmd = "lua vim.lsp.buf.formatting()" },
		{ key = "<leader>" .. lsp_prefix .. "s", cmd = "lua vim.lsp.diagnostic.show_line_diagnostics()" },
		{ key = "<leader>" .. lsp_prefix .. "p", cmd = "lua vim.lsp.diagnostic.goto_prev()" },
		{ key = "<leader>" .. lsp_prefix .. "n", cmd = "lua vim.lsp.diagnostic.goto_next()" },
	}

	for _, key in ipairs(lsp_map) do
		api.nvim_buf_set_keymap(bufnr, "n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end


-- Telescope
local telescope_prefix = "t"
local telescope_map = {
	{ key = "<leader>" .. telescope_prefix .. "t", cmd = "lua require('telescope.builtin').find_files()" },
}

for _, key in ipairs(telescope_map) do
	api.nvim_set_keymap("n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

return MAP

