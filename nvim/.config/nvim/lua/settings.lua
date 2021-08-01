local opt, g, cmd = vim.opt, vim.g, vim.cmd

if not opt.termguicolors or opt.termguicolors ~= nil then
	opt.termguicolors = true
end

g.gruvbox_contrast_dark = "hard" -- soft, medium, hard
g.gruvbox_invert_selection = 0

opt.background = "dark"
g.colors_name = "gruvbox"

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
opt.smartindent = true
opt.smarttab = true
opt.wildmenu = true
opt.wrap = true

