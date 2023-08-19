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
	{
		"ramojus/mellifluous.nvim",
	},


	-- CORE
	-- lsp config
	{
		"neovim/nvim-lspconfig",
	},
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdateSync",
	},

	-- PLUGINS
	-- everybody wants that line
	{
		"strash/everybody-wants-that-line.nvim",
		dev = true,
	},
	{
		"b0o/incline.nvim",
	},
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
	-- indent scope
	{
		"echasnovski/mini.indentscope",
		version = false,
	},
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
		init = function()
			require("neogit").setup({
				kind = "split",
				disable_commit_confirmation = true,
				disable_insert_on_commit = true,
			})
		end
	},
	-- diffview
	{
		"sindrets/diffview.nvim",
	},
	-- buffer manager
	{
		"j-morano/buffer_manager.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		init = function()
			require("buffer_manager").setup({
				width = 100,
				height = 12,
				focus_alternate_buffer = true,
				short_file_names = true,
				short_term_names = true,
			})
		end
	},
	-- oil
	{
		"stevearc/oil.nvim",
		init = function()
			require("oil").setup({
				columns = {},
				view_options = {
					show_hidden = true,
				},
				progress = {
					width = 100,
					height = 12,
					win_options = {
						winblend = 0,
					},
				},
			})
		end
	},
	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		init = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							height = 0.8,
							prompt_position = "top",
							width = 0.5
						},
					},
					prompt_prefix = " ",
					path_display = { "absolute" },
					history = false,
					cache_picker = false,
					preview = false,
					color_devicons = false,
					file_ignore_patterns = {
						".DS_Store",
						".git/",
						".import/",
						".godot/",
						".android/build/",
						"node_modules/",
						"dist/",
						"prisma/migrations/",
						"target/",
						"mini.nvim",
						"obj/",
						"bin/",
					},
				},
			})
		end
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
