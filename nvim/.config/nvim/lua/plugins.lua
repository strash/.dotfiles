vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function()

  use "wbthomason/packer.nvim"
  use "gruvbox-community/gruvbox"
  use {
    "rose-pine/neovim", as = "rose-pine"
  }
  use "folke/tokyonight.nvim"

  use "kyazdani42/nvim-tree.lua"
  use "neovim/nvim-lspconfig"
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "hrsh7th/nvim-compe"
  use "sheerun/vim-polyglot"
  use "tpope/vim-fugitive"
  use "OmniSharp/omnisharp-vim"
  use {
    "dense-analysis/ale",
    ft = { "cs" },
  }
  use {
    "akinsho/flutter-tools.nvim",
    requires = "nvim-lua/plenary.nvim"
  }

end)

