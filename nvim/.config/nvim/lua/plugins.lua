local plug_autogroup = vim.api.nvim_create_augroup("StrPackGroup", {
	clear = true
})

vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = "*/plugins.lua",
	command = "source % | Lazy sync",
	group = plug_autogroup
})


return {
	-- COLORS
	{
		"rebelot/kanagawa.nvim",
		opts = {
			commentStyle = { italic = false },
			keywordStyle = { italic = false },
			statementStyle = { bold = true },
			variablebuiltinStyle = { italic = false },
			specialReturn = true,
			specialException = true,
			transparent = false,
			globalStatus = true,
		},
		config = function()
			--vim.cmd.colo("kanagawa")
		end
	},

	{
		"mcchrish/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim",
		config = function()
			local variant = "zenwritten"
			vim.g[variant] = {
				--darkness = "stark",
				italic_comments = false,
				colorize_diagnostic_underline_text = true,
				transparent_background = false,
			}
			vim.cmd.colo(variant)
		end
	},

	--"catppuccin/nvim",

	--"mofiqul/vscode.nvim",

	--"navarasu/onedark.nvim",

	--{
	--	"rose-pine/neovim",
	--	as = "rose-pine",
	--},

	--"shaunsingh/nord.nvim",

	--"tiagovla/tokyodark.nvim",

	--"yazeed1s/minimal.nvim",


	-- CORE
	{
		"neovim/nvim-lspconfig",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			vim.cmd("TSUpdateSync")
		end,
		lazy = false,
	},


	-- PLUGINS
	{
		"strash/everybody-wants-that-line.nvim",
		dev = true,
		opts = {
			buffer = {
				show = true,
				prefix = "",
				symbol = "0",
				max_symbols = 5,
			},
			filepath = {
				path = "relative", -- tail, relative, full
				shorten = false,
			},
			filesize = {
				metric = "decimal"
			},
			separator = "│",
		},
	},

	{
		"strash/no-one-wants-to-restart.nvim",
		dev = true,
		enabled = false,
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-calc",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",
		},
		lazy = false,
	},

	{
		"TimUntersberger/neogit",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			kind = "split",
			disable_commit_confirmation = true,
			disable_insert_on_commit = true,
		},
	},

	{
		"j-morano/buffer_manager.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			width = 120,
			height = 12,
			focus_alternate_buffer = true,
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
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
				},
			},
		},
	},
}
