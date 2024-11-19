local p = require("plugin_loader").load("mellifluous")

if p ~= nil then
	require("mellifluous").setup({
		colorset = "mellifluous", -- mellifluous, alduin, mountain, tender, kanagawa_dragon
		mellifluous = {
			neutral = true,
			highlight_overrides = {
				dark = function(highlighter, colors)
					highlighter.set("StatusLine", { bg = colors.bg, fg = colors.fg:darkened(15) })
					highlighter.set("StatusLineNC", { bg = colors.bg, fg = colors.fg:darkened(60) })
				end,
				light = function(highlighter, colors)
					highlighter.set("StatusLine", { bg = colors.bg, fg = colors.fg:lightened(15) })
					highlighter.set("StatusLineNC", { bg = colors.bg, fg = colors.fg:lightened(60) })
				end,
			},
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
