local M = {}

function M.merge_config(from, to)
	if type(from) == "table" and from.config ~= nil and type(from.config) == "table" then
		for k, v in pairs(from.config) do
			to[k] = v
		end
	end
end

function M.wrapi(v, min, max)
	local range = max - min
	return range == 0 and min or min + ((((v - min) % range) + range) % range)
end

return M
