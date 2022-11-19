require("nvim-treesitter.configs").setup {
	ensure_installed = { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css",
	"dart", "dockerfile", "gdscript", "glsl", "go", "html",
	"javascript", "jsdoc", "json", "lua", "prisma", "pug", "python", "regex",
	"rust", "scheme", "svelte", "swift", "todotxt", "tsx", "typescript", "vim", },
	highlight = {
		additional_vim_regex_highlighting = false,
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_decremental = "grm",
			node_incremental = "grn",
			scope_incremental = "grc"
		},
	},
	indent = {
		enable = true,
	},
}

