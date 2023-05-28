local opt, cmd = vim.opt, vim.cmd

if not opt.termguicolors or opt.termguicolors ~= nil then
	opt.termguicolors = true
end

opt.background = "dark"

local colo = "kanagawa"

-- COLO KANAGAWA
local kanagawa_config = {
	globalStatus = true,
	transparent = false,
	specialException = true,
	specialReturn = true,
	commentStyle = { italic = false },
	background = {
		dark = "wave", -- wave, dragon
		light = "lotus", -- lotus
	},
}
for _, value in ipairs({ "functionStyle", "keywordStyle", "statementStyle", "typeStyle", "variablebuiltinStyle" }) do
	kanagawa_config[value] = { bold = true, italic = false }
end
require("kanagawa").setup(kanagawa_config)

-- COLO ZENBONES
local variant = "zenwritten"
--colo = variant
vim.g[variant] = {
	italic_comments = false,
	colorize_diagnostic_underline_text = true,
	transparent_background = false,
}

cmd.colo(colo)
cmd.filetype("plugin on")
cmd.filetype("plugin indent on")
cmd.syntax("enable")
cmd.syntax("on")

opt.autowrite = true
opt.autowriteall = true
opt.bufhidden = "wipe"
opt.completeopt = { "menu", "noinsert", "noselect" }
opt.cursorline = true
opt.cursorlineopt = { "number", "screenline" }
opt.fileencoding = "utf-8"
opt.formatoptions = "cqjp"
opt.guicursor = { a = "blinkon0" }
opt.hlsearch = false
opt.inccommand = "split"
opt.laststatus = 3
opt.list = true
opt.listchars = {
	--tab = "⎸ ",
	tab = "  ",
	trail = "✕",
	precedes = "<",
	nbsp = "%",
}
opt.number = true
opt.relativenumber = true
opt.shortmess = "aoOstTWI"
opt.showbreak = ">>"
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.textwidth = 80
opt.colorcolumn = "+1"
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

opt.statuscolumn = " %s%=%{v:relnum?v:relnum:v:lnum} "
