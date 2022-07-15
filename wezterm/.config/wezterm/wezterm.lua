local wezterm = require("wezterm");

return {
	dpi = 144.0,
	font = wezterm.font("SF Mono", {
		--weight = "Regular",
		italic = false
	}),
	font_size = 13.0,
	line_height = 1.0,
	forse_reverse_video_cursor = true,
	text_background_opacity = 1.0,
	hide_tab_bar_if_only_one_tab = true,
	--color_scheme = "GitHub Dark",
	--color_scheme = "zenbones_dark",
	color_scheme = "zenwritten_dark",
	use_fancy_tab_bar = false,
	--window_background_opacity = 0.9,
	window_padding = {
		left = "0px",
		right = "0px",
		top = "0px",
		bottom = "0px",
	},
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = true,
}
