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
	-- zenbones
	{
		"mcchrish/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim" },
	},
	-- kanagawa
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				globalStatus = true,
				transparent = false,
				specialException = true,
				specialReturn = true,
				commentStyle = { italic = false },
				background = {
					dark = "dragon", -- wave, dragon
					light = "lotus", -- lotus
				},
			})
		end,
	},
	-- mellifluous
	{
		"ramojus/mellifluous.nvim",
		config = function()
			require("mellifluous").setup({
				color_set = "mellifluous", -- mellifluous, alduin, mountain, tender, kanagawa_dragon
				neutral = true,
				dim_inactive = false,
				flat_background = {
					line_numbers = true,
					floating_widndows = true,
					file_tree = true,
					cursor_line_number = true,
				},
			})
		end,
	},
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				style = "night", -- storm, moon, night
				light_style = "day",
				day_brightness = 0.25,
			})
		end,
	},
	{
		"cdmill/neomodern.nvim",
		config = function()
			require("neomodern").setup()
		end,
	},

	-- CORE
	-- lsp config
	{ "neovim/nvim-lspconfig" },
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdateSync",
	},

	-- PLUGINS
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
	-- barbecue
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {}
	},
	-- indent blanklines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
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
