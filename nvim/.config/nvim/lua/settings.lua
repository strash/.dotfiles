local M = {}
local opt, cmd = vim.opt, vim.cmd

-- set commentstring for dart files
vim.api.nvim_create_autocmd({ "BufNew", "BufEnter" }, {
	pattern = "*.dart",
	callback = function(args)
		vim.bo[args.buf].commentstring = "// %s"
	end
})

opt.background = "dark"

-- local colo = "zenwritten"
-- local colo = "tokyonight"
-- local colo = "mellifluous"
local colo = "default_but_better"

cmd.colo(colo)
cmd.filetype("plugin on")
cmd.filetype("plugin indent on")
cmd.syntax("enable")
cmd.syntax("on")

opt.autowrite = true
opt.autowriteall = true
opt.bufhidden = "wipe"
opt.cmdheight = 1
opt.colorcolumn = "+1" -- "+1" - show the column, "" - hide
opt.completeopt = { "menu", "noinsert", "noselect", "popup" }
opt.cursorline = false
opt.cursorlineopt = { "number", "screenline" }
opt.fillchars = {
	foldopen = "⌄",
	foldclose = "+",
}
opt.foldcolumn = "1"
opt.formatoptions = "cqjp"
opt.guicursor = {
	"n-v-ve-c-o-r-cr:block",
	"i-ci-sm:ver25",
	"n-c-i-ci-sm:blinkwait700-blinkoff500-blinkon500",
	"a:Cursor/lCursor",
}
opt.inccommand = "split"
opt.linebreak = true
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
opt.showbreak = "↩︎ "
opt.showtabline = 0
opt.signcolumn = "yes"
opt.smoothscroll = true
opt.splitbelow = true
opt.splitright = true
opt.statuscolumn =
	[[  %C %=]] ..
	[[%{%v:relnum?"%#NonText#":"%#Normal#"%}]] ..
	[[%{v:relnum?v:relnum:v:lnum}%* ]] ..
	[[%s]]
opt.statusline =
	[[ %(%H%q%)]] ..
	[[%( %<%{%v:lua.require('util').status_path()%}%M%)]] ..
	[[%=%( %{%v:lua.require('diagnostics').get_diagnostic_count()%}]] ..
	[[ →%02c ↓%{%v:lua.require('util').line_nr(0)%}/%L %03p%%%)  ]]
opt.swapfile = false
opt.textwidth = 80
opt.wildmenu = true
opt.wrap = true

opt.copyindent = true
opt.expandtab = false
opt.shiftwidth = 4
opt.smartindent = true
opt.softtabstop = 0
opt.tabstop = 4

return M
