local api, lsp, cmd, opt = vim.api, vim.lsp, vim.cmd, vim.opt

local function FugitiveInfo()
	local active_buffer_number = tostring(api.nvim_get_var("actual_curbuf"))
	local buffer_number = tostring(api.nvim_get_current_buf())
	local branch = vim.fn.FugitiveHead()

	if branch ~= "" or branch and active_buffer_number == buffer_number then
		return "git(" .. branch .. ")"
	else
		return "not a git"
	end
end

local function LspInfo()
	local active_buffer_number = tostring(api.nvim_get_var("actual_curbuf"))
	local buffer_number = tostring(api.nvim_get_current_buf())
	-- statusline_winid не работает
	--local active_buffer_number = tostring(api.nvim_get_var("statusline_winid"))
	--local buffer_number = tostring(api.nvim_win_get_number(api.nvim_get_current_win()))

	local errors = lsp.diagnostic.get_count(0, "Error")
	local warnings = lsp.diagnostic.get_count(0, "Warning")
	local hints_and_info = lsp.diagnostic.get_count(0, "Hint") + lsp.diagnostic.get_count(0, "Information")

	local error_group, warnings_group, hints_and_info_group

	if errors > 0 and active_buffer_number == buffer_number then
		cmd("hi StrErr ctermfg=167 guifg=#fb4934 ctermbg=239 guibg=#504945")
		error_group = "%#StrErr#"
	else
		error_group = ""
	end
	if warnings > 0 and active_buffer_number == buffer_number then
		cmd("hi StrWarning ctermfg=214 guifg=#fabd2f ctermbg=239 guibg=#504945")
		warnings_group = "%#StrWarning#"
	else
		warnings_group = ""
	end
	if hints_and_info > 0 and active_buffer_number == buffer_number then
		cmd("hi StrHint ctermfg=108 guifg=#8ec07c ctermbg=239 guibg=#504945")
		hints_and_info_group = "%#StrHint#"
	else
		hints_and_info_group = ""
	end

	return error_group .. errors .. "%*, " ..
				 warnings_group .. warnings .. "%*, " ..
				 hints_and_info_group .. hints_and_info .. "%*"
end

function StatusString()
	local persent_sign = "%%"
	local left_side = string.format(" :b %%n%%m | %s%%=", LspInfo())
	local center = string.format("%%f | %s%%=", FugitiveInfo())
	local right_side = string.format("%%L (%%p%s) | %%c ", persent_sign)

	local buffer_name = string.find(api.nvim_buf_get_name(0), "NvimTree")
	if buffer_name then
		return "NvimTree"
	else
		return " " .. left_side .. center .. right_side
	end
end

opt.statusline = "%{%v:lua.StatusString()%}"

