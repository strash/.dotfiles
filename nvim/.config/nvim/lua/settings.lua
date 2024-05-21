local M = {}
local opt, cmd = vim.opt, vim.cmd

opt.background = "dark"

--local colo = "zenwritten"
--local colo = "kanagawa"
--local colo = "mellifluous"
--local colo = "tokyonight"
--local colo = "default"
local colo = "coffeecat" -- neomodern, iceclimber, coffeecat, darkforest, campfire, roseprime, daylight

-- COLO KANAGAWA
require("kanagawa").setup({
	globalStatus = true,
	transparent = false,
	specialException = true,
	specialReturn = true,
	commentStyle = { italic = false },
	background = {
		dark = "dragon", -- wave, dragon
		light = "lotus", -- lotus
	},
})

-- COLO MELLIFLUOUS
require("mellifluous").setup({
	color_set = "mellifluous", -- mellifluous, alduin, mountain, tender, kanagawa_dragon
	neutral = true,
	dim_inactive = false,
	flat_background = {
		line_numbers = true,
		floating_widndows = true,
		file_tree = true,
		cursor_line_number = true,
	},
})

-- COLO TOKYONIGHT
require("tokyonight").setup({
	style = "night", -- storm, moon, night
	light_style = "day",
	day_brightness = 0.25,
})

cmd.colo(colo)
cmd.filetype("plugin on")
cmd.filetype("plugin indent on")
cmd.syntax("enable")
cmd.syntax("on")

opt.autowrite = true
opt.autowriteall = true
opt.bufhidden = "wipe"
opt.cmdheight = 1
opt.colorcolumn = "+1"
opt.completeopt = { "menu", "noinsert", "noselect", "popup" }
opt.cursorline = true
opt.cursorlineopt = { "number", "screenline" }
opt.fileencoding = "utf-8"
opt.fillchars = {
	foldopen = "⌄",
	foldclose = ">",
}
opt.foldcolumn = "1"
opt.formatoptions = "cqjp"
opt.guicursor = { a = "blinkon0" }
opt.hlsearch = false
opt.inccommand = "split"
opt.laststatus = 2
opt.list = true
opt.listchars = {
	tab = "▏ ",
	trail = "✕",
	precedes = "<",
	nbsp = "%",
}
opt.number = true
opt.relativenumber = true
opt.shortmess = "aoOstTWCF"
opt.showbreak = "<<- "
opt.showcmd = false
opt.showcmdloc = "statusline"
opt.showtabline = 0
opt.signcolumn = "yes"
opt.smoothscroll = true
opt.splitbelow = true
opt.splitright = true
opt.statuscolumn = "%C%s%=%{v:relnum?v:relnum:v:lnum} "
opt.statusline =
	[[%( %H%q%)]] ..
	[[%( %<%{%v:lua.require('filepath').get_path()%}%M%)]] ..
	[[%=%( %{%v:lua.require('diagnostics').get_diagnostic_count()%}  %l↓ %3p%% %)]]
opt.swapfile = false
opt.textwidth = 80
opt.wildmenu = true
opt.wrap = true

opt.autoindent = true
opt.copyindent = true
opt.expandtab = false
opt.shiftwidth = 4
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 0
opt.tabstop = 4

-- set commentstring for dart files
vim.api.nvim_create_autocmd({ "BufNew", "BufEnter" }, {
	pattern = "*.dart",
	callback = function(args)
		vim.bo[args.buf].commentstring = "// %s"
	end
})

return M
