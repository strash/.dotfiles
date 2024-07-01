local map_util = require("map_util")

local M = {}

-- leader key
vim.g.mapleader = " "

---@type vim.keymap.set.Opts
local options = {
	noremap = true,
	silent = true,
}

---Global
---@type map_table[]
local global_map = {
	{ mode = "n", key = "<Tab>",   cmd = map_util.wrap_in_cmd("bn"), opts = { desc = "next buffer" } },
	{ mode = "n", key = "<S-Tab>", cmd = map_util.wrap_in_cmd("bp"), opts = { desc = "prev buffer" } },
	{ mode = "i", key = "<C-C>",   cmd = "<ESC>",                    opts = { desc = "exit insert mode" } },
	{ mode = "t", key = "<C-ESC>", cmd = [[<C-\><C-N>]],             opts = { desc = "exit insert mode in terminal" } },
	-- { mode = { "n", "v" }, key = "<C-d>",   cmd = "<C-d>zz",                  opts = { desc = "scroll up and align the cursor" } },
	-- { mode = { "n", "v" }, key = "<C-u>",   cmd = "<C-u>zz",                  opts = { desc = "scroll down and align the cursor" } },
	{
		mode = { "n", "i", "s" },
		key = "<CR>",
		cmd = function()
			if vim.snippet.active() then
				return map_util.wrap_in_cmd("lua vim.snippet.stop()")
			else
				return "<CR>"
			end
		end,
		opts = { desc = "scroll down and align the cursor", expr = true }
	},
}
map_util.set_keymap(global_map, nil, options)

local global_leader = "<leader>"
---@type map_table[]
local global_w_leader_map = {
	{ key = "w",  cmd = map_util.wrap_in_cmd("wa"),                        opts = { desc = "write all buffer" } },
	{ key = "bd", cmd = function() map_util.delete_wipe_window("bd") end,  opts = { desc = "delete buffer" } },
	{ key = "bm", cmd = function() map_util.toggle_buffer_manager() end,   opts = { desc = "open buffer manager" } },
	{ key = "o",  cmd = function() map_util.open_oil() end,                opts = { desc = "open oil" } },
	{ key = "cc", cmd = map_util.wrap_in_cmd("cc"),                        opts = { desc = "open first error" } },
	{ key = "cn", cmd = map_util.wrap_in_cmd("cn"),                        opts = { desc = "next entry point form the quicklist" } },
	{ key = "cp", cmd = map_util.wrap_in_cmd("cp"),                        opts = { desc = "prew entry point form the quicklist" } },
	{ key = "so", cmd = map_util.wrap_in_cmd("so %"),                      opts = { desc = "source nvim config" } },
	{ key = "tt", cmd = function() map_util.open_terminal() end,           opts = { desc = "open terminal window" } },
	{ key = "bb", cmd = function() map_util.toggle_background_color() end, opts = { desc = "toggle background color" } },
	{ key = "gg", cmd = function() map_util.open_neogit_window() end,      opts = { desc = "open neogit" } },
	{ key = "r",  cmd = function() vim.lsp.buf.rename() end,               opts = { desc = "rename" } },
}
map_util.set_keymap(global_w_leader_map, global_leader, options)

function M.set_lsp_map(_, bufnr)
	local lsp_prefix = "<leader>s"
	---@type vim.keymap.set.Opts
	local opts = { noremap = true, silent = true, buffer = bufnr }
	---@type map_table[]
	local lsp_map = {
		{ key = "d", cmd = function() vim.lsp.buf.definition() end },
		{ key = "c", cmd = function() vim.lsp.buf.declaration() end },
		{ key = "i", cmd = function() vim.lsp.buf.implementation() end },
		{ key = "r", cmd = function() vim.lsp.buf.references() end },
		{ key = "q", cmd = function() vim.diagnostic.setqflist() end },
		{
			mode = { "n", "v" },
			key = "a",
			cmd = function()
				require("fzf-lua").lsp_code_actions()
			end
		},
	}
	map_util.set_keymap(lsp_map, lsp_prefix, opts)
	vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
end

-- Package manager
local packer_prefix = "<leader>p"
---@type map_table[]
local packer_map = { { key = "s", cmd = map_util.wrap_in_cmd("Lazy sync") } }
map_util.set_keymap(packer_map, packer_prefix, options)

-- Fzf
local fzf_prefix = "<leader>f"
---@type map_table[]
local fzf_map = {
	{ key = "f", cmd = function() require("fzf-lua").files({ cmd = map_util.find_files() }) end, opts = { desc = "find files" } },
	{ key = "g", cmd = function() require("fzf-lua").live_grep() end,                            opts = { desc = "live grep" } },
	{ key = "u", cmd = function() require("fzf-lua").lsp_finder() end,                           opts = { desc = "lsp finder for things under cursor" } },
	{ key = "r", cmd = function() require("fzf-lua").lsp_references() end,                       opts = { desc = "lsp references" } },
	{ key = "d", cmd = function() require("fzf-lua").lsp_definitions() end,                      opts = { desc = "lsp definitions" } },
	{ key = "c", cmd = function() require("fzf-lua").lsp_declarations() end,                     opts = { desc = "lsp declarations" } },
	{ key = "t", cmd = function() require("fzf-lua").lsp_typedefs() end,                         opts = { desc = "lsp typedefs" } },
	{ key = "i", cmd = function() require("fzf-lua").lsp_implementations() end,                  opts = { desc = "lsp implementations" } },
	{ key = "q", cmd = function() require("fzf-lua").quickfix() end,                             opts = { desc = "search in quickfix" } },
	{ key = "e", cmd = function() require("fzf-lua").diagnostics_workspace() end,                opts = { desc = "lsp diagnostics workspace" } },
	{
		mode = { "n", "v" },
		key = "w",
		cmd = function()
			map_util.fzf_grep_word()
		end,
		opts = { desc = "grep a word under cursor" }
	},
}
map_util.set_keymap(fzf_map, fzf_prefix, options)

return M
