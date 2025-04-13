local M = {}

function M.status_path()
	local path = vim.fn.expand("%:~:.")
	-- if path == "" or vim.bo.buftype ~= "" then
	-- 	return "%t"
	-- end
	return path
end

function M.line_nr(bufnr)
	local count = vim.api.nvim_buf_line_count(bufnr)
	local pad = #vim.fn.string(count)
	return "%0" .. pad .. "l"
end

return M
