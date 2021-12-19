local api, lsp, cmd, opt = vim.api, vim.lsp, vim.cmd, vim.opt

local function FugitiveInfo()
	local active_buffer_number = tostring(api.nvim_get_var("actual_curbuf"))
	local buffer_number = tostring(api.nvim_get_current_buf())
	local branch = vim.fn.FugitiveHead()
	local result
	if branch ~= "" or branch and active_buffer_number == buffer_number then
		result = branch
	else
		result = "not a git"
	end

	return string.format("[%s]", result)
end

local function GetHlGroupColor(group, color)
	local group_table = api.nvim_get_hl_by_name(group, true)
	return string.format("#%06x", group_table[color])
end

local function LspInfo()
	local active_buffer_number = tostring(api.nvim_get_var("actual_curbuf"))
	local buffer_number = tostring(api.nvim_get_current_buf())
	local errors = lsp.diagnostic.get_count(0, "Error")
	local warnings = lsp.diagnostic.get_count(0, "Warning")
	local hints_and_info = lsp.diagnostic.get_count(0, "Hint") + lsp.diagnostic.get_count(0, "Information")

	local error_group, warnings_group, hints_and_info_group

	if errors > 0 and active_buffer_number == buffer_number then
		cmd("hi StrErr cterm=bold guifg=" .. GetHlGroupColor("DiagnosticError", "foreground") .. " guibg=" .. GetHlGroupColor("StatusLine", "background"))
		error_group = "%#StrErr#"
	else
		error_group = ""
	end
	if warnings > 0 and active_buffer_number == buffer_number then
		cmd("hi StrWarning cterm=bold guifg=" .. GetHlGroupColor("DiagnosticWarn", "foreground") .. " guibg=" .. GetHlGroupColor("StatusLine", "background"))
		warnings_group = "%#StrWarning#"
	else
		warnings_group = ""
	end
	if hints_and_info > 0 and active_buffer_number == buffer_number then
		cmd("hi StrInfo cterm=bold guifg=" .. GetHlGroupColor("DiagnosticInfo", "foreground") .. " guibg=" .. GetHlGroupColor("StatusLine", "background"))
		hints_and_info_group = "%#StrInfo#"
	else
		hints_and_info_group = ""
	end

	return error_group .. errors .. "%*, " .. warnings_group .. warnings .. "%*, " .. hints_and_info_group .. hints_and_info .. "%*"
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

