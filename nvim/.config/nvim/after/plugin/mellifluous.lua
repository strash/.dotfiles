local p = require("plugin_loader").load("mellifluous")

if p ~= nil then
	require("mellifluous").setup({
		colorset = "mellifluous", -- mellifluous, alduin, mountain, tender, kanagawa_dragon
		mellifluous = {
			neutral = true,
		},
		dim_inactive = false,
		flat_background = {
			line_numbers = true,
			floating_widndows = true,
			file_tree = true,
			cursor_line_number = true,
		},
	})
end
