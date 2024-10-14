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
	{ "ramojus/mellifluous.nvim", lazy = false },

	-- lavish
	{ "ferdinandrau/lavish.nvim", lazy = false },

	-- zenbones
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
	},

	-- tokyonight
	{ "folke/tokyonight.nvim", lazy = false },

	-- CORE
	-- lsp config
	{ "neovim/nvim-lspconfig", lazy = false },
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdateSync",
		lazy = false,
	},

	-- PLUGINS
	{ "echasnovski/mini.icons", lazy = false },
	-- blink
	{
		"saghen/blink.cmp",
		lazy = false,
		version = "v0.*",
		-- enabled = false,
	},
	-- cmp
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		enabled = false,
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
		lazy = false,
		dependencies = "nvim-lua/plenary.nvim",
		-- enabled = false,
	},
	-- buffer manager
	{
		"j-morano/buffer_manager.nvim",
		lazy = false,
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- oil
	{ "stevearc/oil.nvim",      lazy = false },
	-- fzf lua
	{ "ibhagwan/fzf-lua",       lazy = false },
	-- pretty quickfix
	{ "yorickpeterse/nvim-pqf", lazy = false },
}, {
	dev = {
		path = "~/FOSS",
	},
	readme = {
		enabled = false,
	},
})
