local opt, g, cmd = vim.opt, vim.g, vim.cmd

if not opt.termguicolors or opt.termguicolors ~= nil then
	opt.termguicolors = true
end

opt.background = "dark"

g.gruvbox_contrast_dark = "hard" -- soft, medium, hard
g.gruvbox_invert_selection = 0
g.colors_name = "gruvbox"

g.rose_pine_variant = "moon" -- base, moon, dawn
g.rose_pine_disable_italics = false
g.rose_pine_disable_background = false
--g.colors_name = "rose-pine"

g.OmniSharp_server_use_mono = 1
g.OmniSharp_diagnostic_showid = 1

g.ale_linters = {
	cs = { "omnisharp" },
}


cmd("filetype plugin on")
cmd("filetype plugin indent on")
cmd("syntax enable")
cmd("syntax on")


opt.autowrite = true
opt.autowriteall = true
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.fileencoding = "utf-8"
opt.guicursor = { a = "blinkon0" }
opt.hidden = true
opt.list = true
opt.listchars = { tab = "--", trail = "~" }
opt.hlsearch = false
opt.swapfile = false
opt.number = true
opt.relativenumber = true
opt.shortmess = "aoOstTWI"
opt.showcmd = true
opt.splitbelow = true
opt.splitright = true
opt.wildmenu = true
opt.wrap = true

opt.autoindent = true
opt.copyindent = false
opt.expandtab = false
--opt.shiftwidth = 2
opt.smartindent = true
opt.smarttab = true
--opt.softtabstop = 0
--opt.tabstop = 8

