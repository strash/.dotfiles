local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

	-- mellifluous
	-- {
	-- 	"ramojus/mellifluous.nvim",
	-- 	dev = false,
	-- },
	-- zenbones
	-- {
	-- 	"mcchrish/zenbones.nvim",
	-- 	dependencies = { "rktjmp/lush.nvim" },
	-- },

	-- CORE

	-- lsp config
	{ "neovim/nvim-lspconfig", },
	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdateSync",
	},

	-- PLUGINS

	-- mini icons
	{ "echasnovski/mini.icons", },
	-- blink
	{
		"saghen/blink.cmp",
		version = "v0.*",
		-- enabled = false,
	},
	-- neogit
	{
		"NeogitOrg/neogit",
		dependencies = "nvim-lua/plenary.nvim",
		-- enabled = false,
	},
	-- buffer manager
	{
		"j-morano/buffer_manager.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	-- oil
	{ "stevearc/oil.nvim", },
	-- quicker
	{
		"stevearc/quicker.nvim",
		event = "FileType qf",
		enabled = false,
	},
	-- fzf lua
	{ "ibhagwan/fzf-lua", },
}, {
	dev = {
		path = "~/Developer/FOSS",
	},
	readme = {
		enabled = false,
	},
})
