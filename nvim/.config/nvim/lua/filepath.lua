local M = {}

---@alias filepath_cache_path_part_split { path: string, shorten: string, filename: string }
---@alias filepath_cache_path_parts { relative: filepath_cache_path_part_split, full: filepath_cache_path_part_split }

---`filepath_cache`
---@type { [string]: filepath_cache_path_parts }
local cache = {}

---@alias laststatus
---| 0 #never
---| 1 #only if there are at least two windows
---| 2 #always
---| 3 #always and ONLY the last window

---Static. Returns `laststatus`
---@return laststatus
function M.laststatus()
	return vim.o.laststatus
end

---Static. Check if statusline on focused window
---@return boolean
function M.is_focused()
	if M.laststatus() == 3 then
		return true
	end
	return tonumber(vim.g.actual_curwin) == tonumber(vim.api.nvim_get_current_win())
end

---Static. Returns current buffer number
---@return integer
function M.get_bufnr()
	local bufnr = 0
	if M.laststatus() == 3 then
		bufnr = tonumber(vim.api.nvim_get_current_buf()) or 0
	else
		if M.is_focused() then
			bufnr = tonumber(vim.g.actual_curbuf) or 0
		else
			bufnr = tonumber(vim.api.nvim_get_current_buf()) or 0
		end
	end
	return bufnr
end

---Returns splitted path and filename
---@param path string
---@return filepath_cache_path_part_split
local function split_path_and_filename(path)
	local f = path:match("[^/\\]+$") or ""
	local p = path:sub(0, #path - #f)
	return { path = p, shorten = vim.fn.pathshorten(p), filename = f }
end

---Returns path to the file
---@param buf_id number
---@return filepath_cache_path_parts
function M.get_filepath(buf_id)
	---@type filepath_cache_path_parts
	local path_parts = {
		relative = {
			path = "",
			shorten = "",
			filename = "",
		},
		full = {
			path = "",
			shorten = "",
			filename = "",
		},
	}
	---@type string
	local fullpath = vim.api.nvim_buf_get_name(buf_id)
	if fullpath ~= nil and #fullpath ~= 0 then
		if cache[fullpath] ~= nil then
			path_parts = cache[fullpath]
		else
			path_parts.full = split_path_and_filename(fullpath)
			---@type string
			local relative = ""
			local cwd = vim.fn.getcwd(0)
			local _, r_e = fullpath:find(cwd, 0, true)
			if r_e ~= nil then
				local rel = fullpath:sub(r_e + 2)
				relative = #rel ~= 0 and "./" .. rel or ""
			else
				relative = "./" .. relative
			end
			path_parts.relative = split_path_and_filename(relative)
			cache[fullpath] = path_parts
		end
	end
	return path_parts
end

return M
