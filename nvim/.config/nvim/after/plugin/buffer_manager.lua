local p = require("plugin_loader").load("buffer_manager")

if p ~= nil then
	require("buffer_manager").setup({
		width = 100,
		height = 30,
		focus_alternate_buffer = true,
		short_term_names = true,
		show_indicators = nil,
		order_buffers = nil,
	})
end
