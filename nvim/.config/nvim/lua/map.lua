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
	{ mode = "n", key = "<Tab>",      cmd = map_util.wrap_in_cmd("bn"),                  opts = { desc = "next buffer" } },
	{ mode = "n", key = "<S-Tab>",    cmd = map_util.wrap_in_cmd("bp"),                  opts = { desc = "prev buffer" } },
	{ mode = "n", key = "grn",        cmd = function() vim.lsp.buf.rename() end,         opts = { desc = "rename" } },
	-- { mode = "n", key = "grr",        cmd = function() vim.lsp.buf.references() end,     opts = { desc = "lsp references" } },
	{ mode = "n", key = "gri",        cmd = function() vim.lsp.buf.implementation() end, opts = { desc = "lsp implementations" } },
	{ mode = "n", key = "gd",         cmd = function() vim.lsp.buf.definition() end,     opts = { desc = "lsp go to definition" } },
	-- { mode = "n",          key = "grq",        cmd = function() vim.diagnostic.setqflist() end,   opts = { desc = "show diagnostics" } },
	-- { mode = { "n", "v" }, key = "gra",        cmd = function() vim.lsp.buf.code_action() end,    opts = { desc = "lsp code actions" } },
	{ mode = "n", key = "grh",        cmd = map_util.wrap_in_cmd("noh"),                 opts = { desc = "stop the highlighting for the hlsearch" } },
	-- { mode = "i",          key = "<C-s>",      cmd = function() vim.lsp.buf.signature_help() end, opts = { desc = "signature help" } },
	{ mode = "i", key = "<C-c>",      cmd = "<ESC>",                                     opts = { desc = "exit insert mode" } },
	{ mode = "t", key = "<ESC><ESC>", cmd = [[<C-\><C-n>]],                              opts = { desc = "exit insert mode in terminal" } },
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
		opts = { desc = "stop snippet", expr = true }
	},
}
map_util.set_keymap(global_map, nil, options)

local global_leader = "<leader>"
---@type map_table[]
local global_w_leader_map = {
	{ mode = "n", key = "w",  cmd = function() map_util.format_and_save_all_buffers() end, opts = { desc = "format and write all buffer" } },
	{ mode = "n", key = "bd", cmd = function() map_util.delete_wipe_window("bd") end,      opts = { desc = "delete buffer" } },
	{ mode = "n", key = "bm", cmd = function() map_util.toggle_buffer_manager() end,       opts = { desc = "open buffer manager" } },
	{ mode = "n", key = "o",  cmd = function() map_util.open_oil() end,                    opts = { desc = "open oil" } },
	{ mode = "n", key = "cc", cmd = map_util.wrap_in_cmd("cc"),                            opts = { desc = "open first error" } },
	{ mode = "n", key = "cn", cmd = map_util.wrap_in_cmd("cn"),                            opts = { desc = "next entry point form the quicklist" } },
	{ mode = "n", key = "cp", cmd = map_util.wrap_in_cmd("cp"),                            opts = { desc = "prew entry point form the quicklist" } },
	{ mode = "n", key = "co", cmd = map_util.wrap_in_cmd("cope"),                          opts = { desc = "open quicklist" } },
	{ mode = "n", key = "cl", cmd = map_util.wrap_in_cmd("ccl"),                           opts = { desc = "close quicklist" } },
	{ mode = "n", key = "so", cmd = map_util.wrap_in_cmd("so %"),                          opts = { desc = "source nvim config" } },
	{ mode = "n", key = "tt", cmd = function() map_util.open_terminal() end,               opts = { desc = "open terminal window" } },
	{ mode = "n", key = "ih", cmd = function() map_util.toggle_inlay_hints() end,          opts = { desc = "toggle inlay hints" } },
	{ mode = "n", key = "bb", cmd = function() map_util.toggle_background_color() end,     opts = { desc = "toggle background color" } },
	{ mode = "n", key = "gg", cmd = function() map_util.open_neogit_window() end,          opts = { desc = "open neogit" } },
	{ mode = "v", key = "dh", cmd = function() map_util.decimal_to_hexadecimal() end,      opts = { desc = "prints selected decimal as hexadecimal" }, },
}
map_util.set_keymap(global_w_leader_map, global_leader, options)

-- Package manager
local packer_prefix = "<leader>p"
---@type map_table[]
local packer_map = { { key = "s", cmd = map_util.wrap_in_cmd("Lazy sync") } }
map_util.set_keymap(packer_map, packer_prefix, options)

-- Fzf
local fzf_lua = require("plugin_loader").load("fzf-lua")
if fzf_lua ~= nil then
	local fzf_prefix = "<leader>f"

	---@type map_table[]
	local fzf_map = {
		{ mode = { "n", "v" }, key = "b", cmd = function() fzf_lua.builtin() end,                              opts = { desc = "builtin" } },
		{ mode = "n",          key = "f", cmd = function() fzf_lua.files({ cmd = map_util.find_files() }) end, opts = { desc = "find files" } },
		{ mode = "n",          key = "g", cmd = function() fzf_lua.live_grep() end,                            opts = { desc = "live grep" } },
		{ mode = { "n", "v" }, key = "w", cmd = function() map_util.fzf_grep_word() end,                       opts = { desc = "grep a word under cursor" } },
		{ mode = "n",          key = "e", cmd = function() fzf_lua.diagnostics_workspace() end,                opts = { desc = "lsp diagnostics workspace" } },
		{ mode = "n",          key = "r", cmd = function() fzf_lua.lsp_references() end,                       opts = { desc = "lsp references" } },
		{ mode = "n",          key = "s", cmd = function() fzf_lua.lsp_document_symbols() end,                 opts = { desc = "lsp workspace symbols" } },
		{ mode = "n",          key = "a", cmd = function() fzf_lua.lsp_code_actions() end,                     opts = { desc = "lsp code actions" } },
	}
	map_util.set_keymap(fzf_map, fzf_prefix, options)
end

return M
