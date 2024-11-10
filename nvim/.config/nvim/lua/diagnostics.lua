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

local empty_diagnostic = "│ OK │"

function M.get_diagnostic_count()
	if vim.diagnostic.is_enabled() then
		---@type number[]
		local count = vim.diagnostic.count(nil)
		local res = ""
		if count[vim.diagnostic.severity.ERROR] ~= nil then
			local c = count[vim.diagnostic.severity.ERROR]
			res = append(res, "E:" .. c)
		end
		if count[vim.diagnostic.severity.WARN] ~= nil then
			local c = count[vim.diagnostic.severity.WARN]
			res = append(res, "W:" .. c)
		end
		if count[vim.diagnostic.severity.INFO] ~= nil then
			local c = count[vim.diagnostic.severity.INFO]
			res = append(res, "I:" .. c)
		end
		if count[vim.diagnostic.severity.HINT] ~= nil then
			local c = count[vim.diagnostic.severity.HINT]
			res = append(res, "H:" .. c)
		end

		if #res > 0 then
			return "│ " .. res .. " │"
		end
	end
	return empty_diagnostic
end

return M
