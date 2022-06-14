local api, cmd, opt, diag = vim.api, vim.cmd, vim.opt, vim.diagnostic

local function get_hl_group_color(group, color)
	local group_table = api.nvim_get_hl_by_name(group, true)
	return string.format("#%06x", group_table[color])
end

local function get_git_branch()
	local branch = ""
	if vim.fn.isdirectory ".git" ~= 0 then
		-- always runs in the current directory, rather than in the buffer's directory
		branch = vim.fn.system("git branch --show-current | tr -d '\n'")
	else
		branch = "not a git"
	end
	cmd("hi StrBranch cterm=bold guifg=" ..
		get_hl_group_color("Comment", "foreground") .. " guibg=" .. get_hl_group_color("StatusLine", "background"))
	return "%#StrBranch#" .. branch .. "%*"
end

local function get_lsp_info()
	local errors = diag.get(0, { severity = diag.severity.ERROR })
	local warnings = diag.get(0, { severity = diag.severity.WARN })
	local hints = diag.get(0, { severity = diag.severity.HINT })
	local infos = diag.get(0, { severity = diag.severity.INFO })

	local error_group, warnings_group, hints_and_info_group
	local err, warn, info

	if #errors > 0 then
		cmd("hi StrErr cterm=bold guifg=" ..
			get_hl_group_color("DiagnosticError", "foreground") .. " guibg=" .. get_hl_group_color("StatusLine", "background"))
		error_group = "%#StrErr#"
		err = #errors .. " (" .. errors[1].lnum + 1 .. ")"
	else
		error_group = ""
		err = 0
	end
	if #warnings > 0 then
		cmd("hi StrWarning cterm=bold guifg=" ..
			get_hl_group_color("DiagnosticWarn", "foreground") .. " guibg=" .. get_hl_group_color("StatusLine", "background"))
		warnings_group = "%#StrWarning#"
		warn = #warnings .. " (" .. warnings[1].lnum + 1 .. ")"
	else
		warnings_group = ""
		warn = 0
	end
	if #hints > 0 or #infos > 0 then
		cmd("hi StrInfo cterm=bold guifg=" ..
			get_hl_group_color("DiagnosticInfo", "foreground") .. " guibg=" .. get_hl_group_color("StatusLine", "background"))
		hints_and_info_group = "%#StrInfo#"
		if #hints > 0 and #infos > 0 and hints[1].lnum < infos[1].lnum then
			info = #hints + #infos .. " (" .. hints[1].lnum .. ")"
		elseif #hints > 0 and #infos == 0 then
			info = #hints .. " (" .. hints[1].lnum + 1 .. ")"
		elseif #hints == 0 and #infos > 0 then
			info = #infos .. " (" .. infos[1].lnum + 1 .. ")"
		end
	else
		hints_and_info_group = ""
		info = 0
	end

	return error_group .. err .. "%*, " .. warnings_group .. warn .. "%*, " .. hints_and_info_group .. info .. "%*"
end

local function set_statusline_content()
	local persent_sign = "%%"
	local left_side = string.format("b %%M%%n | %s%%=", get_lsp_info())
	local center = string.format("%s - %%f%%=", get_git_branch())
	local right_side = string.format("%%L (%%p%s) | %%c ", persent_sign)

	local buffer_name_nvimtree = string.find(api.nvim_buf_get_name(0), "NvimTree")
	local buffer_name_packer = string.match(api.nvim_buf_get_name(0), "%[%w-%]$")
	local buffer_name_doc = string.find(api.nvim_buf_get_name(0), "/doc/") and string.find(api.nvim_buf_get_name(0), ".txt")
	local buffer_name_fugitive = string.find(api.nvim_buf_get_name(0), ".git/index")
	local string_format = "%%=%s%%="

	local content = ""
	if buffer_name_nvimtree then
		content = string.format(string_format, "NvimTree")
	elseif buffer_name_doc then
		content = string.format("%%=Help - %s%%=", string.match(api.nvim_buf_get_name(0), "[%s%w_]-%.%w-$")) .. right_side
	elseif buffer_name_packer then
		content = string.format(string_format, "Packer")
	elseif buffer_name_fugitive then
		content = string.format(string_format, "Fugitive")
	else
		content = " " .. left_side .. center .. right_side
	end

	opt.statusline = content
end

local statusline_group = api.nvim_create_augroup("StatuslineGroup", {
	clear = true,
})

api.nvim_create_autocmd({
	"BufAdd",
	"BufEnter",
	"BufWritePost",
	"FocusGained",
	"ColorScheme",
	"DiagnosticChanged",
}, {
	callback = set_statusline_content,
	group = statusline_group,
})

