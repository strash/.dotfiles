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

return require("packer").startup(function(use)
	-- Packer
	use("wbthomason/packer.nvim")

	-- Colorschemes
	use({
		"mcchrish/zenbones.nvim",
		requires = "rktjmp/lush.nvim"
	})
	use("catppuccin/nvim")
	use("rose-pine/neovim")
	use("Mofiqul/vscode.nvim")
	use("shaunsingh/nord.nvim")
	use("navarasu/onedark.nvim")
	use("rebelot/kanagawa.nvim")
	use("tiagovla/tokyodark.nvim")

	-- Core
	use("neovim/nvim-lspconfig")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- Plugins
	--use("strash/everybody-wants-that-line.nvim")
	use("/Users/strash/FOSS/everybody-wants-that-line.nvim")
	--use("strash/no-one-wants-to-restart.nvim")
	use("/Users/strash/FOSS/no-one-wants-to-restart.nvim")

	use("OmniSharp/omnisharp-vim")

	use("L3MON4D3/LuaSnip")

	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")

	use({
		"TimUntersberger/neogit",
		requires = "nvim-lua/plenary.nvim"
	})
	use("tpope/vim-fugitive")

	use({
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
	})
end)
