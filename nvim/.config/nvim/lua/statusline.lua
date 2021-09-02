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
	-- gruvbox colors
	local bg_gruvbox = "guibg=#504945"
	local err_gruvbox = "guifg=#fb4934"
	local warn_gruvbox = "guifg=#fabd2f"
	local info_gruvbox = "guifg=#8ec07c"
	-- rose-pine colors
	local bg_rose_pine = "guibg=#1f1d2e"
	local err_rose_pine = "guifg=#eb6f92"
	local warn_rose_pine = "guifg=#f6c177"
	local info_rose_pine = "guifg=#c4a7e7"

	if errors > 0 and active_buffer_number == buffer_number then
		--cmd("hi StrErr " .. err_gruvbox .. " " .. bg_gruvbox)
		cmd("hi StrErr " .. err_rose_pine .. " " .. bg_rose_pine)
		error_group = "%#StrErr#"
	else
		error_group = ""
	end
	if warnings > 0 and active_buffer_number == buffer_number then
		--cmd("hi StrWarning " .. warn_gruvbox .. " " .. bg_gruvbox)
		cmd("hi StrWarning " .. warn_rose_pine .. " " .. bg_rose_pine)
		warnings_group = "%#StrWarning#"
	else
		warnings_group = ""
	end
	if hints_and_info > 0 and active_buffer_number == buffer_number then
		--cmd("hi StrHint " .. info_gruvbox .. " " .. bg_gruvbox)
		cmd("hi StrHint " .. info_rose_pine .. " " .. bg_rose_pine)
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

	local buffer_name_nvimtree = string.find(api.nvim_buf_get_name(0), "NvimTree")
	local buffer_name_packer = string.find(api.nvim_buf_get_name(0), "packer")
	if buffer_name_nvimtree then
		return string.format("%%=%s%%=", "NvimTree")
	elseif buffer_name_packer then
		return string.format("%%=%s%%=", "Packer")
	else
		return " " .. left_side .. center .. right_side
	end
end

opt.statusline = "%{%v:lua.StatusString()%}"

