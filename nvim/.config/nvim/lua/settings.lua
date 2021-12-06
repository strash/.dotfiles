local opt, g, cmd = vim.opt, vim.g, vim.cmd

if not opt.termguicolors or opt.termguicolors ~= nil then
	opt.termguicolors = true
end

opt.background = "dark"

g.gruvbox_contrast_dark = "hard" -- soft, medium, hard
g.gruvbox_invert_selection = 0
--cmd("colorscheme gruvbox")

g.rose_pine_variant = "moon" -- base, moon, dawn
g.rose_pine_disable_italics = true
g.rose_pine_disable_background = false
--cmd("colorscheme rose-pine")

g.vscode_style = "dark"
cmd("colorscheme vscode")

cmd("filetype plugin on")
cmd("filetype plugin indent on")
cmd("syntax enable")
cmd("syntax on")

opt.autowrite = true
opt.autowriteall = true
opt.breakindent = false
opt.bufhidden = "wipe"
opt.completeopt = { "menu", "noinsert", "noselect" }
opt.cursorline = true
opt.cursorlineopt = { "number", "screenline" }
opt.fileencoding = "utf-8"
opt.guicursor = { a = "blinkon0" }
opt.hlsearch = false
opt.inccommand = "split"
opt.linebreak = true
opt.list = true
	opt.listchars = {
	tab = "--",
	trail = "~",
	eol = "\\u21b5",
	space = "·",
	lead = ".",
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
opt.wildmenu = true
opt.wrap = true
opt.wrapmargin = 0

opt.autoindent = true
opt.copyindent = false
opt.expandtab = false
--opt.shiftwidth = 2
opt.smartindent = true
opt.smarttab = true
--opt.softtabstop = 0
--opt.tabstop = 8

