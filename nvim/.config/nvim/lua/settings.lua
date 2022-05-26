local opt, g, cmd, api = vim.opt, vim.g, vim.cmd, vim.api

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

cmd("highlight Normal guibg=none")
cmd("highlight NonText guibg=none")
cmd("highlight WinSeparator guibg=none")

api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js", },
	command = "EslintFixAll",
})

opt.autowrite = true
opt.autowriteall = true
opt.bufhidden = "wipe"
opt.completeopt = { "menu", "noinsert", "noselect" }
opt.cursorline = false
opt.cursorlineopt = { "number", "screenline" }
opt.fileencoding = "utf-8"
opt.formatoptions = "cqjp"
opt.guicursor = { a = "blinkon0" }
opt.hlsearch = false
opt.inccommand = "split"
opt.laststatus = 3
opt.list = true
opt.listchars = {
	tab = "--",
	trail = "~",
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
opt.wildmenu = true
opt.wrap = true

opt.autoindent = true
opt.copyindent = true
opt.expandtab = false
opt.shiftwidth = 4
opt.smartindent = true
opt.smarttab = true
opt.softtabstop = 4
opt.tabstop = 4

