require("nvim-treesitter.configs").setup {
	ensure_installed = "maintained",
	sync_install = false,
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
	},
}

