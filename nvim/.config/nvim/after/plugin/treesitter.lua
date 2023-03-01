require("nvim-treesitter.configs").setup({
	ensure_installed = { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css",
		"dart", "dockerfile", "fish", "gdscript", "glsl", "go", "html",
		"javascript", "jsdoc", "json", "lua", "prisma", "pug", "python", "regex",
		"rust", "scheme", "svelte", "swift", "todotxt", "tsx", "typescript", "vim", },
	highlight = {
		additional_vim_regex_highlighting = false,
		enable = true,
	},
	indent = {
		enable = true,
	},
})