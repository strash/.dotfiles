local map_util = require("map_util")

local M = {}

-- leader key
vim.g.mapleader = " "

local options = {
	noremap = true,
	silent = true,
}

-- Global
local global_map = {
	{ key = "<Tab>",      cmd = "bn" },                                           -- next buffer
	{ key = "<S-Tab>",    cmd = "bp" },                                           -- prev buffer
	{ key = "<leader>w",  cmd = "wa" },                                           -- write buffers
	{ key = "<leader>bd", cmd = function() map_util.delete_wipe_window("bd") end }, -- delete buffer
	--{ key = "<leader>bw", cmd = function() map_util.delete_wipe_window("bw") end }, -- wipe buffer
	{ key = "<leader>bm", cmd = function() map_util.toggle_buffer_manager() end }, -- open buffer manager
	{ key = "<leader>o",  cmd = function() map_util.open_oil() end },             -- open oil
	{ key = "<leader>cc", cmd = "cc" },                                           -- open first error
	{ key = "<leader>cn", cmd = "cn" },                                           -- next entry point form the quicklist
	{ key = "<leader>cp", cmd = "cp" },                                           -- prew entry point form the quicklist
	{ key = "<leader>so", cmd = "so %" },                                         -- source nvim config
	{ key = "<leader>tt", cmd = function() map_util.open_terminal() end },        -- open terminal window
	{ key = "<leader>bb", cmd = function() map_util.toggle_background_color() end }, -- toggle background color
	{ key = "<leader>gg", cmd = function() map_util.open_neogit_window() end },   -- open neogit
	{ key = "<leader>r",  cmd = function() vim.lsp.buf.rename() end },            -- rename
}
map_util.set_keymap(global_map, "", options)
vim.keymap.set("i", "<C-C>", "<Esc>", options)            -- exit insert mode
vim.keymap.set("t", "<C-Esc>", [[<C-\><C-N>]], options)   -- exit insert mode in terminal
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", options) -- scroll up and align the cursor
vim.keymap.set({ "n", "v" }, "<C-b>", "<C-b>zz", options) -- scroll down and align the cursor

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
		{ key = "d", cmd = function() vim.lsp.buf.definition() end },
		{ key = "c", cmd = function() vim.lsp.buf.declaration() end },
		{ key = "i", cmd = function() vim.lsp.buf.implementation() end },
		{ key = "r", cmd = function() vim.lsp.buf.references() end },
		--{ key = "f", cmd = function() vim.lsp.buf.format() end },
		--{ key = "e", cmd = function() vim.lsp.buf.signature_help() end },
		{ key = "s", cmd = function() vim.diagnostic.open_float() end },
		{ key = "p", cmd = function() vim.diagnostic.goto_prev() end },
		{ key = "n", cmd = function() vim.diagnostic.goto_next() end },
		{ key = "q", cmd = function() vim.diagnostic.setqflist() end },
	}
	map_util.set_keymap(lsp_map, lsp_prefix, opts)
	vim.keymap.set({ "n", "v" }, lsp_prefix .. "a", function() require("fzf-lua").lsp_code_actions() end, opts)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- Package manager
local packer_prefix = "<leader>p"
local packer_map = {
	{ key = "s", cmd = "Lazy sync" }
}
map_util.set_keymap(packer_map, packer_prefix, options)

-- Fzf
local fzf_prefix = "<leader>f"
local fzf_map = {
	{ key = "f", cmd = function() require("fzf-lua").files({ cmd = map_util.find_files() }) end }, -- files
	{ key = "g", cmd = function() require("fzf-lua").live_grep() end },                         -- live grep
	{ key = "u", cmd = function() require("fzf-lua").lsp_finder() end },                        -- lsp finder for things under cursor
	{ key = "r", cmd = function() require("fzf-lua").lsp_references() end },                    -- lsp references
	{ key = "d", cmd = function() require("fzf-lua").lsp_definitions() end },                   -- lsp definitions
	{ key = "c", cmd = function() require("fzf-lua").lsp_declarations() end },                  -- lsp declarations
	{ key = "t", cmd = function() require("fzf-lua").lsp_typedefs() end },                      -- lsp typedefs
	{ key = "i", cmd = function() require("fzf-lua").lsp_implementations() end },               -- lsp implementations
	{ key = "q", cmd = function() require("fzf-lua").quickfix() end },                          -- quickfix
	{ key = "e", cmd = function() require("fzf-lua").diagnostics_workspace() end },             -- lsp diagnostics workspace
}
map_util.set_keymap(fzf_map, fzf_prefix, options)
-- grep a word under cursor
vim.keymap.set({ "n", "v" }, fzf_prefix .. "w", function() map_util.fzf_grep_word() end, options)

return M
