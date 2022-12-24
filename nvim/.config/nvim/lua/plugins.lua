local pack_autogroup = vim.api.nvim_create_augroup("StrPackGroup", {
	clear = true
})

vim.api.nvim_create_autocmd({
	"BufWritePost",
}, {
	pattern = "*/plugins.lua",
	command = "source % | Lazy sync",
	group = pack_autogroup
})


return {
	"rebelot/kanagawa.nvim",

	{
		"mcchrish/zenbones.nvim",
		dependencies = "rktjmp/lush.nvim"
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
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = "TSUpdate",
		lazy = false,
	},


	-- PLUGINS
	{
		"strash/everybody-wants-that-line.nvim",
		dev = true,
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
	},
	{
		"TimUntersberger/neogit",
		dependencies = "nvim-lua/plenary.nvim"
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"j-morano/buffer_manager.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
}

