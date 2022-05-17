local api, cmd, opt, diag = vim.api, vim.cmd, vim.opt, vim.diagnostic

local function FugitiveInfo()
	local active_buffer_number = tostring(api.nvim_get_var("actual_curbuf"))
	local buffer_number = tostring(api.nvim_get_current_buf())
	local branch = vim.fn.FugitiveStatusline()
	local result
	if branch ~= "" or branch and active_buffer_number == buffer_number then
		result = string.sub(branch, 6, string.len(branch) - 2)
	else
		result = "not a git"
	end

	return string.format("[ %s ]", result)
end

local function GetHlGroupColor(group, color)
	local group_table = api.nvim_get_hl_by_name(group, true)
	return string.format("#%06x", group_table[color])
end

local function LspInfo()
	local active_buffer_number = tostring(api.nvim_get_var("actual_curbuf"))
	local buffer_number = tostring(api.nvim_get_current_buf())
	local errors = diag.get(0, { severity = diag.severity.ERROR })
	local warnings = diag.get(0, { severity = diag.severity.WARN })
	local hints = diag.get(0, { severity = diag.severity.HINT })
	local infos = diag.get(0, { severity = diag.severity.INFO })

	local error_group, warnings_group, hints_and_info_group

	local err, warn, info

	if #errors > 0 and active_buffer_number == buffer_number then
		cmd("hi StrErr cterm=bold guifg=" .. GetHlGroupColor("DiagnosticError", "foreground") .. " guibg=" .. GetHlGroupColor("StatusLine", "background"))
		error_group = "%#StrErr#"
		err = #errors .. " (" .. errors[1].lnum + 1 .. ")"
	else
		error_group = ""
		err = 0
	end
	if #warnings > 0 and active_buffer_number == buffer_number then
		cmd("hi StrWarning cterm=bold guifg=" .. GetHlGroupColor("DiagnosticWarn", "foreground") .. " guibg=" .. GetHlGroupColor("StatusLine", "background"))
		warnings_group = "%#StrWarning#"
		warn = #warnings .. " (" .. warnings[1].lnum + 1 .. ")"
	else
		warnings_group = ""
		warn = 0
	end
	if #hints > 0 and active_buffer_number == buffer_number or #infos > 0 and active_buffer_number == buffer_number then
		cmd("hi StrInfo cterm=bold guifg=" .. GetHlGroupColor("DiagnosticInfo", "foreground") .. " guibg=" .. GetHlGroupColor("StatusLine", "background"))
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

function StatusString()
	local persent_sign = "%%"
	local left_side = string.format(" :b %%n%%m | %s%%=", LspInfo())
	local center = string.format("%s - %%f%%=", FugitiveInfo())
	local right_side = string.format("%%L (%%p%s) | %%c ", persent_sign)

	local buffer_name_nvimtree = string.find(api.nvim_buf_get_name(0), "NvimTree")
	local buffer_name_packer = string.match(api.nvim_buf_get_name(0), "%[%w-%]$")
	local buffer_name_doc = string.find(api.nvim_buf_get_name(0), "/doc/") and string.find(api.nvim_buf_get_name(0), ".txt")
	local buffer_name_fugitive = string.find(api.nvim_buf_get_name(0), ".git/index")
	local string_format = "%%=%s%%="
	if buffer_name_nvimtree then
		return string.format(string_format, "NvimTree")
	elseif buffer_name_doc then
		return string.format("%%=help - %s%%=", string.match(api.nvim_buf_get_name(0), "[%s%w_]-%.%w-$")) .. right_side
	elseif buffer_name_packer then
		return string.format(string_format, "Packer")
	elseif buffer_name_fugitive then
		return string.format(string_format, "Fugitive")
	else
		return " " .. left_side .. center .. right_side
	end
	--return api.nvim_buf_get_name(0)
end

opt.statusline = "%{%v:lua.StatusString()%}"

