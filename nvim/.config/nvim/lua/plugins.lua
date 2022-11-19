vim.cmd("packadd packer.nvim")

local packer_autogroup = vim.api.nvim_create_augroup("StrPackerGroup", {
	clear = true
})

vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = "*/plugins.lua",
	command = "source % | PackerSync",
	group = packer_autogroup
})

return require("packer").startup({
	function(use)

		-- PACKER

		use("wbthomason/packer.nvim")


		-- COLORSCHEMES

		use("rebelot/kanagawa.nvim")
		--use({
		--	"mcchrish/zenbones.nvim",
		--	requires = "rktjmp/lush.nvim"
		--})
		--use("catppuccin/nvim")
		--use("mofiqul/vscode.nvim")
		--use("navarasu/onedark.nvim")
		--use({
		--	"rose-pine/neovim",
		--	as = "rose-pine",
		--})
		--use("shaunsingh/nord.nvim")
		--use("tiagovla/tokyodark.nvim")
		--use("yazeed1s/minimal.nvim")


		-- CORE

		use("neovim/nvim-lspconfig")
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})


		-- PLUGINS

		--use("strash/everybody-wants-that-line.nvim")
		use("/Users/strash/FOSS/everybody-wants-that-line.nvim")
		--use("strash/no-one-wants-to-restart.nvim")
		--use({
		--	"/Users/strash/FOSS/no-one-wants-to-restart.nvim",
		--	ft = "lua",
		--})

		use({
			"OmniSharp/omnisharp-vim",
			ft = { "cs", "sln", "csproj" },
		})

		use("L3MON4D3/LuaSnip")

		use("saadparwaiz1/cmp_luasnip")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-calc")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lsp-signature-help")
		use("hrsh7th/nvim-cmp")

		use("nvim-treesitter/nvim-treesitter-context")

		use({
			"TimUntersberger/neogit",
			requires = "nvim-lua/plenary.nvim"
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = "nvim-lua/plenary.nvim",
		})

		use("echasnovski/mini.bufremove")

	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end
		},
		profile = {
			enable = false,
		},
	}
})
