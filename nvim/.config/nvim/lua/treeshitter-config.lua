require("nvim-treesitter.configs").setup {
	ensure_installed = nil,
	sync_install = false,
	highlight = {
		enable = true, -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
	},
	incrmmental_selection = {
		enable = true,
	},
	indent = {
		enable = true,
	},
}

