local M = {}

---append to diagnostic string
---@param src string
---@param value string
local function append(src, value)
	if #src > 0 then
		return src .. " " .. value
	end
	return value
end

local important_sign = "→"
local not_important_sign = "•"

vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = important_sign,
			[vim.diagnostic.severity.WARN] = important_sign,
			[vim.diagnostic.severity.INFO] = not_important_sign,
			[vim.diagnostic.severity.HINT] = not_important_sign,
		},
	}
})

-- local ok_diagnostic = "│ OK │"
local ok_diagnostic = "OK •"

function M.get_diagnostic_count()
	if vim.diagnostic.is_enabled() then
		---@type number[]
		local diagnostics = vim.diagnostic.count(nil)
		local res = ""
		if diagnostics[vim.diagnostic.severity.HINT] ~= nil then
			local c = diagnostics[vim.diagnostic.severity.HINT]
			res = append(res, "%#DiagnosticHint#" .. c .. "%*")
		end
		if diagnostics[vim.diagnostic.severity.INFO] ~= nil then
			local c = diagnostics[vim.diagnostic.severity.INFO]
			res = append(res, "%#DiagnosticInfo#" .. c .. "%*")
		end
		if diagnostics[vim.diagnostic.severity.WARN] ~= nil then
			local c = diagnostics[vim.diagnostic.severity.WARN]
			res = append(res, "%#DiagnosticWarn#" .. c .. "%*")
		end
		if diagnostics[vim.diagnostic.severity.ERROR] ~= nil then
			local c = diagnostics[vim.diagnostic.severity.ERROR]
			res = append(res, "%#DiagnosticError#" .. c .. "%*")
		end
		if #res > 0 then
			return res .. " •"
		end
	end
	return ok_diagnostic
end

return M
