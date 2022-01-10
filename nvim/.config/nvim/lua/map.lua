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
	{ key = "<leader>w", cmd = "bd" },
	{ key = "<leader>n", cmd = "Explore" },
}

for _, key in ipairs(global_map) do
	api.nvim_set_keymap("n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end


-- LSP
local lsp_prefix = "<leader>s"
function MAP.set_lsp_map(_, bufnr)

	local lsp_map = {
		{ key = lsp_prefix .. "h", cmd = "lua vim.lsp.buf.hover()" },
		{ key = lsp_prefix .. "r", cmd = "lua vim.lsp.buf.rename()" },
		{ key = lsp_prefix .. "a", cmd = "lua vim.lsp.buf.code_action()" },
		{ key = lsp_prefix .. "g", cmd = "lua vim.lsp.buf.declaration()" },
		{ key = lsp_prefix .. "d", cmd = "lua vim.lsp.buf.definition()" },
		{ key = lsp_prefix .. "i", cmd = "lua vim.lsp.buf.implementation()" },
		{ key = lsp_prefix .. "f", cmd = "lua vim.lsp.buf.formatting()" },
		{ key = lsp_prefix .. "s", cmd = "lua vim.diagnostic.show()" },
		{ key = lsp_prefix .. "p", cmd = "lua vim.diagnostic.goto_prev()" },
		{ key = lsp_prefix .. "n", cmd = "lua vim.diagnostic.goto_next()" },
	}

	for _, key in ipairs(lsp_map) do
		api.nvim_buf_set_keymap(bufnr, "n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end


-- Telescope
local telescope_prefix = "<leader>t"
local telescope_map = {
	{ key = telescope_prefix .. "f", cmd = "lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true, })" },
	{ key = telescope_prefix .. "t", cmd = "lua require('telescope.builtin').treesitter()" },
	{ key = telescope_prefix .. "c", cmd = "lua require('telescope.builtin').current_buffer_fuzzy_find()" },
	{ key = telescope_prefix .. "g", cmd = "lua require('telescope.builtin').git_branches()" },
	{ key = telescope_prefix .. "h", cmd = "lua require('telescope.builtin').command_history()" },
	{ key = telescope_prefix .. "b", cmd = "lua require('telescope.builtin').buffers({ show_all_buffers = true, ignore_current_buffer = false, sort_lastused = true, sort_mru = true, })" },
	{ key = telescope_prefix .. "r", cmd = "lua require('telescope.builtin').registers()" },
}

for _, key in ipairs(telescope_map) do
	api.nvim_set_keymap("n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

return MAP

