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
local colo = "default"

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
-- local variant = "zenwritten"
--colo = variant
-- vim.g[variant] = {
-- 	italic_comments = false,
-- 	colorize_diagnostic_underline_text = true,
-- 	transparent_background = false,
-- }

-- COLO MELLIFLUOUS
-- require("mellifluous").setup({
-- 	color_set = "mellifluous", -- "mellifluous", "alduin", "mountain", "tender", "kanagawa_dragon"
-- 	neutral = true,
-- 	dim_inactive = false,
-- 	flat_background = {
-- 		line_numbers = true,
-- 		floating_widndows = true,
-- 		file_tree = true,
-- 		cursor_line_number = true,
-- 	},
-- })

-- COLO TOKYONIGHT
require("tokyonight").setup({
	style = "night", -- storm, moon, night
	light_style = "day",
	day_brightness = 0.25,
})

function M._get_path()
	local path = filepath.get_filepath(filepath.get_bufnr())
	return path["relative"].path .. path["relative"].filename
end

function M._get_diagnostic_count()
	---append to diagnostic string
	---@param src string
	---@param value string
	local function append(src, value)
		if #src > 0 then
			return src .. ", " .. value
		end
		return src .. value
	end

	local empty_diagnostic = "[OK]"

	if vim.diagnostic.is_enabled() then
		---@type number[]
		local count = vim.diagnostic.count(nil)
		local a = vim.tbl_values(count)
		local res = ""
		if a[vim.diagnostic.severity.E] ~= nil then
			res = append(res, "E:" .. a[vim.diagnostic.severity.E])
		end
		if a[vim.diagnostic.severity.W] ~= nil then
			res = append(res, "W:" .. a[vim.diagnostic.severity.W])
		end
		if a[vim.diagnostic.severity.I] ~= nil then
			res = append(res, "I:" .. a[vim.diagnostic.severity.I])
		end
		if a[vim.diagnostic.severity.N] ~= nil then
			res = append(res, "H:" .. a[vim.diagnostic.severity.H])
		end
		if #res > 0 then
			return "[" .. res .. "]"
		end
		return empty_diagnostic
	end
	return empty_diagnostic
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
opt.laststatus = 3
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
[[%( %H%q%)%( %<%{%v:lua.require('settings')._get_path()%}%M%)%=%( %{%v:lua.require('settings')._get_diagnostic_count()%} %l↓ %3p%% %)]]
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
