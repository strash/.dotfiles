local M = {}

function M.load(plugin)
	if package.loaded[plugin] then
		return require(plugin)
	else
		local status, _ = pcall(require, plugin)
		if status then
			return require(plugin)
		end
	end
	return nil
end

return M
