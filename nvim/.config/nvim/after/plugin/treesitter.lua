local p = require("plugin_loader").load("nvim-treesitter.configs")

if p ~= nil then
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c_sharp",
			"cmake",
			"comment",
			"cpp",
			"css",
			"dart",
			"gdscript",
			"go",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"ocaml",
			"ocaml_interface",
			"ocamllex",
			"prisma",
			"regex",
			"rescript",
			"scheme",
			"sql",
			"svelte",
			"todotxt",
			"tsx",
			"typescript",
			"zig",
		},
		sync_install = true,
		ignore_install = {},
		modules = {},
		auto_install = true,
		incremental_selection = {
			enable = false,
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = false,
		},
	})
end
