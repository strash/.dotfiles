local function FugitiveInfo()
	local branch = vim.fn["fugitive#head"]()
	if branch == "" or not branch then
		return "('git init')"
	else
		return "git(" .. branch .. ")"
	end
end

local function LspInfo()
	local errors = vim.lsp.diagnostic.get_count(0, "Error")
	local warnings = vim.lsp.diagnostic.get_count(0, "Warning")
	local hints_and_info = vim.lsp.diagnostic.get_count(0, "Hint") + vim.lsp.diagnostic.get_count(0, "Information")

	return "%#LspDiagnosticsDefaultError#" .. errors ..
				 "%*, %#LspDiagnosticsDefaultWarning#" .. warnings ..
				 "%*, %#LspDiagnosticsDefaultHint#" .. hints_and_info .. "%*"
end

function StatusString()
	local persent_sign = "%%"
	local status_string = " %%-10.(:b %%n%%m%%) %%<%%f : %s    [%s] %%= %%L (%%p%s) | %%c "
	return string.format(status_string,
											 FugitiveInfo(),
											 LspInfo(),
											 persent_sign)
end

vim.o.statusline = "%!v:lua.StatusString()"

