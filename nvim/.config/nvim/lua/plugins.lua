local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plug_autogroup = vim.api.nvim_create_augroup("StrPackGroup", {
	clear = true
})

vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = "*/plugins.lua",
	command = "Lazy sync",
	group = plug_autogroup
})

return require("lazy").setup({
	-- COLORS
	-- mellifluous
	{ "ramojus/mellifluous.nvim" },

	-- CORE
	-- lsp config
	{ "neovim/nvim-lspconfig" },
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdateSync",
	},

	-- PLUGINS
	{ "echasnovski/mini.icons" },
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
	},
	-- neogit
	{
		"NeogitOrg/neogit",
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- buffer manager
	{
		"j-morano/buffer_manager.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- oil
	{ "stevearc/oil.nvim" },
	-- fzf lua
	{ "ibhagwan/fzf-lua" },
	-- pretty quickfix
	{ "yorickpeterse/nvim-pqf" },
}, {
	dev = {
		path = "~/FOSS",
	},
	readme = {
		enabled = false,
	},
})
