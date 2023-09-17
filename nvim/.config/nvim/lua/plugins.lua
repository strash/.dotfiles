local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	-- kanagawa
	{
		"rebelot/kanagawa.nvim",
		build = ":KanagawaCompile",
	},
	-- zenbones
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
	},
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
	-- everybody wants that line
	--{
	--	"strash/everybody-wants-that-line.nvim",
	--	dev = true,
	--},
	-- incline
	--{ "b0o/incline.nvim" },
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
		},
	},
	-- gitsigns
	{ "lewis6991/gitsigns.nvim" },
	-- flutter tools
	{
		"akinsho/flutter-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "dart",
	},
	-- neogit
	{
		"NeogitOrg/neogit",
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- diffview
	{ "sindrets/diffview.nvim" },
	-- buffer manager
	{
		"j-morano/buffer_manager.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- oil
	{ "stevearc/oil.nvim" },
	-- fzf lua
	{ "ibhagwan/fzf-lua" },
	-- telescope
	--{
	--	"nvim-telescope/telescope.nvim",
	--	dependencies = "nvim-lua/plenary.nvim",
	--},
}, {
	defaults = {
		lazy = false,
	},
	dev = {
		path = "~/FOSS",
	},
	checker = {
		notify = false,
	},
	change_detection = {
		notify = false,
	},
	readme = {
		enabled = false,
	},
})
