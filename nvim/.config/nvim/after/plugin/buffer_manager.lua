local p = require("plugin_loader").load("buffer_manager")

if p ~= nil then
	require("buffer_manager").setup({
		width = 130,
		height = 30,
		focus_alternate_buffer = true,
		short_file_names = false,
		short_term_names = true,
		loop_nav = true,
		show_indicators = nil,
		order_buffers = nil,
	})
end
