require("_packer_compiled")

local plug_autogroup = vim.api.nvim_create_augroup("StrPackGroup", {
	clear = true
})

vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = "*/plugins.lua",
	command = "source % | PackerSync",
	group = plug_autogroup
})

return require("packer").startup({
	config = {
		compile_path = vim.fn.stdpath("config") .. "/lua/_packer_compiled.lua",
		autoremove = true,
	},
	function(use)
		use("wbthomason/packer.nvim")


		-- COLORS
		use("rebelot/kanagawa.nvim")

		use({
			"mcchrish/zenbones.nvim",
			requires = "rktjmp/lush.nvim",
		})

		use("askfiy/visual_studio_code")


		-- CORE
		use("neovim/nvim-lspconfig")

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdateSync",
		})


		-- PLUGINS
		use({
			"~/FOSS/everybody-wants-that-line.nvim",
			config = function()
				require("everybody-wants-that-line").setup({
					buffer = {
						prefix = "",
						symbol = "·",
					},
				})
			end
		})

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-calc",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"L3MON4D3/LuaSnip",
			},
		})

		use({
			"TimUntersberger/neogit",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("neogit").setup({
					kind = "split",
					disable_commit_confirmation = true,
					disable_insert_on_commit = true,
				})
			end
		})

		use({
			"j-morano/buffer_manager.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("buffer_manager").setup({
					width = 100,
					height = 12,
					focus_alternate_buffer = true,
				})
			end
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
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
		})
	end
})
