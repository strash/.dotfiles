vim.cmd("packadd packer.nvim")

return require("packer").startup(function()
	use "wbthomason/packer.nvim"
	use "Mofiqul/vscode.nvim"
	use {
		"mcchrish/zenbones.nvim",
		requires = "rktjmp/lush.nvim"
	}
	use "neovim/nvim-lspconfig"
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use "OmniSharp/omnisharp-vim"
	use "L3MON4D3/LuaSnip"
	use "saadparwaiz1/cmp_luasnip"
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-buffer"
	use "hrsh7th/nvim-cmp"
	use "tpope/vim-fugitive"
	use {
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim",
	}
end)
