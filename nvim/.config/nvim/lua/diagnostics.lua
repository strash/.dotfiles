local M = {}

---append to diagnostic string
---@param src string
---@param value string
local function append(src, value)
	if #src > 0 then
		return src .. ", " .. value
	end
	return value
end

local empty_diagnostic = "[OK]"

function M.get_diagnostic_count()
	if vim.diagnostic.is_enabled() then
		---@type number[]
		local count = vim.diagnostic.count(nil)
		local res = ""
		if count[vim.diagnostic.severity.ERROR] ~= nil then
			res = append(res, "E:" .. count[vim.diagnostic.severity.ERROR])
		end
		if count[vim.diagnostic.severity.WARN] ~= nil then
			res = append(res, "W:" .. count[vim.diagnostic.severity.WARN])
		end
		if count[vim.diagnostic.severity.INFO] ~= nil then
			res = append(res, "I:" .. count[vim.diagnostic.severity.INFO])
		end
		if count[vim.diagnostic.severity.HINT] ~= nil then
			res = append(res, "H:" .. count[vim.diagnostic.severity.HINT])
		end

		if #res > 0 then
			return "[" .. res .. "]"
		end
	end
	return empty_diagnostic
end

return M
