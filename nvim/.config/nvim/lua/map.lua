local M = {}
local api = vim.api

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
		print("- setted light background -")
	else
		M.background_color = "dark"
		print("- setted dark background -")
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
	{ key = "<leader>gn", cmd = "Explore" }, -- open netrw
	{ key = "<leader>cn", cmd = "cn" }, -- next entry point form the quicklist
	{ key = "<leader>cp", cmd = "cp" }, -- prew entry point form the quicklist
	{ key = "<leader>gr", cmd = "so %" }, -- source nvim config
	{ key = "<leader>bb", cmd = "lua require('map').toggle_background_color()" }, -- toggle background color

	{ key = "<leader>gg", cmd = "G" }, -- fugitive
}

for _, key in ipairs(global_map) do
	api.nvim_set_keymap("n", key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

-- ReloadModule
local reload_module_prefix = "<leader>r"
local reload_module_map = {
	{ key = "a", cmd = "ReloadModuleAdd" },
	{ key = "r", cmd = "ReloadModule" },
	{ key = "l", cmd = "ReloadModuleList" },
}

for _, key in ipairs(reload_module_map) do
	api.nvim_set_keymap("n", reload_module_prefix .. key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

-- LSP
local lsp_prefix = "<leader>s"
function M.set_lsp_map(_, bufnr)
	local lsp_map = {
		{ key = "h", cmd = "lua vim.lsp.buf.hover()" },
		{ key = "r", cmd = "lua vim.lsp.buf.rename()" },
		{ key = "a", cmd = "lua vim.lsp.buf.code_action()" },
		{ key = "g", cmd = "lua vim.lsp.buf.declaration()" },
		{ key = "d", cmd = "lua vim.lsp.buf.definition()" },
		{ key = "i", cmd = "lua vim.lsp.buf.implementation()" },
		{ key = "c", cmd = "lua vim.lsp.buf.references()" },
		{ key = "f", cmd = "lua vim.lsp.buf.formatting()" },
		{ key = "e", cmd = "lua vim.lsp.buf.signature_help()" },
		{ key = "s", cmd = "lua vim.diagnostic.open_float()" },
		{ key = "p", cmd = "lua vim.diagnostic.goto_prev()" },
		{ key = "n", cmd = "lua vim.diagnostic.goto_next()" },
	}

	for _, key in ipairs(lsp_map) do
		api.nvim_buf_set_keymap(bufnr, "n", lsp_prefix .. key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
	end

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Telescope
local telescope_prefix = "<leader>t"
local r_t = "require('telescope.builtin')"
local telescope_map = {
	{ key = "f", cmd = "lua " .. r_t .. ".find_files({ hidden = true, no_ignore = true, })" },
	{ key = "t", cmd = "lua " .. r_t .. ".treesitter()" },
	{ key = "s", cmd = "lua " .. r_t .. ".lsp_document_symbols({ ignore_symbols = {'variable', 'field', 'property'}})" },
	{ key = "c", cmd = "lua " .. r_t .. ".current_buffer_fuzzy_find()" },
	{ key = "g", cmd = "lua " .. r_t .. ".git_branches()" },
	{ key = "h", cmd = "lua " .. r_t .. ".command_history()" },
	{ key = "b", cmd = "lua " .. r_t .. ".buffers({ show_all_buffers = true, ignore_current_buffer = false, sort_lastused = true, sort_mru = true })" },
	{ key = "r", cmd = "lua " .. r_t .. ".registers()" },
}

for _, key in ipairs(telescope_map) do
	api.nvim_set_keymap("n", telescope_prefix .. key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

-- Packer
local packer_prefix = "<leader>p"
local packer_map = {
	{ key = "s", cmd = "PackerSync" }
}

for _, key in ipairs(packer_map) do
	api.nvim_set_keymap("n", packer_prefix .. key.key, "<Cmd>" .. key.cmd .. "<CR>", options)
end

return M
