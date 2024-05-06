---Returns splitted path and filename
local split_path_and_filename = function(filepath)
	local f = filepath:match("[^/\\]+$") or ""
	local p = filepath:sub(0, #filepath - #f)
	return { path = p, shorten = vim.fn.pathshorten(p), filename = f }
end

local get_filepath = function(filepath, is_relative)
	local path_parts = {
		path = "",
		shorten = "",
		filename = "",
	}

	if filepath ~= nil and #filepath ~= 0 then
		if is_relative then
			return split_path_and_filename(filepath)
		else
			local relative = ""
			local cwd = vim.fn.getcwd(0)
			local _, r_e = filepath:find(cwd, 0, true)
			if r_e ~= nil then
				local rel = filepath:sub(r_e + 2)
				relative = #rel ~= 0 and "./" .. rel or ""
			else
				relative = "./" .. relative
			end
			return split_path_and_filename(relative)
		end
	end
	return path_parts
end

local is_shorten = false

require("buffer_manager").setup({
	width = 130,
	height = 30,
	focus_alternate_buffer = true,
	short_file_names = false,
	short_term_names = true,
	loop_nav = true,
	show_indicators = "before",
	format_function = function(filepath)
		-- NonTexttrue Normal
		local path_parts = get_filepath(filepath, false)
		if is_shorten then
			return path_parts.shorten .. path_parts.filename
		end
		return path_parts.path .. path_parts.filename
	end
})
