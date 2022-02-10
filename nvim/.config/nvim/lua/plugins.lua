vim.cmd("packadd packer.nvim")

return require("packer").startup(function()
	use "wbthomason/packer.nvim"
	use "Mofiqul/vscode.nvim"
	use "neovim/nvim-lspconfig"
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use "OmniSharp/omnisharp-vim"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/nvim-cmp"
	use "tpope/vim-fugitive"
	use {
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
	}
end)
