local M = {}

local filepath = require("filepath")

local opt, cmd = vim.opt, vim.cmd

if not opt.termguicolors or opt.termguicolors ~= nil then
	opt.termguicolors = true
end

opt.background = "dark"

--local colo = "zenwritten"
--local colo = "kanagawa"
--local colo = "mellifluous"
--local colo = "tokyonight"
--local colo = "astrotheme"
local colo = "oxocarbon"

-- COLO KANAGAWA
--local kanagawa_config = {
--	globalStatus = true,
--	transparent = false,
--	specialException = true,
--	specialReturn = true,
--	commentStyle = { italic = false },
--	background = {
--		dark = "dragon", -- wave, dragon
--		light = "lotus", -- lotus
--	},
--}
--for _, value in ipairs({
--	"functionStyle",
--	"keywordStyle",
--	"statementStyle",
--	"typeStyle",
--	"variablebuiltinStyle",
--}) do
--	kanagawa_config[value] = { bold = true, italic = false }
--end
--require("kanagawa").setup(kanagawa_config)

-- COLO ZENBONES
local variant = "zenwritten"
--colo = variant
vim.g[variant] = {
	italic_comments = false,
	colorize_diagnostic_underline_text = true,
	transparent_background = false,
}

-- COLO MELLIFLUOUS
require("mellifluous").setup({
	color_set = "mellifluous", -- "mellifluous", "alduin", "mountain", "tender", "kanagawa_dragon"
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
	style = "night",
	day_brightness = 0.2
})

-- COLO ASTROTHEME
require("astrotheme").setup({
	style = {
		inactive = false,
	}
})

function M._get_path()
	local path = filepath.get_filepath(filepath.get_bufnr())
	return path["relative"].path .. path["relative"].filename
end

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
opt.completeopt = { "menu", "noinsert", "noselect" }
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
opt.shortmess = "aoOsTW"
opt.showbreak = ">>"
opt.showcmd = false
opt.showcmdloc = "statusline"
opt.showtabline = 0
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.statuscolumn = " %C%s%=%{v:relnum?v:relnum:v:lnum}  "
--opt.statusline = [[%( %H%q%)%( %<%{%pathshorten(bufname())%}%M%)%=%(%l↓ %3p%% %)]]
opt.statusline =
[[%( %H%q%)%( %<%{%v:lua.require('settings')._get_path()%}%M%)%=%(%l↓ %3p%% %)]]
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

return M
