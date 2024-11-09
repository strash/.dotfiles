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
-- local colo = "kanagawa"
local colo = "mellifluous"
-- local colo = "lavish"
-- local colo = "tokyonight"
-- local colo = "coffeecat" -- neomodern, iceclimber, coffeecat, darkforest, campfire, roseprime, daylight
-- local colo = "default"

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
opt.showbreak = "<<< "
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
	[[%( %<%{%v:lua.require('util').status_path()%}%M%)]] ..
	[[%=%( %{%v:lua.require('diagnostics').get_diagnostic_count()%}]] ..
	[[ →%02c ↓%{%v:lua.require('util').line_nr(0)%}/%L %03p%% %)]]
opt.swapfile = false
opt.textwidth = 80
opt.updatetime = 500
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
