local p = require("plugin_loader").load("buffer_manager")

if p ~= nil then
	require("buffer_manager").setup({
		width = 90,
		height = 26,
		focus_alternate_buffer = true,
		short_term_names = true,
		show_indicators = nil,
		order_buffers = "fullpath",
	})
end
