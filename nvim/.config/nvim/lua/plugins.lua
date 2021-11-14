vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()
	use "wbthomason/packer.nvim"
	use "gruvbox-community/gruvbox"
	use "kyazdani42/nvim-tree.lua"
	use "neovim/nvim-lspconfig"
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/nvim-cmp"
	use "tpope/vim-fugitive"
	use "OmniSharp/omnisharp-vim"
	use {
		"akinsho/flutter-tools.nvim",
		requires = "nvim-lua/plenary.nvim"
	}
end)

