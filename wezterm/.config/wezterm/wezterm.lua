local wezterm = require("wezterm");

return {
	dpi = 144.0,
	font = wezterm.font("SF Mono", { weight = "Regular", italic = false }),
	font_size = 17.0,
	forse_reverse_video_cursor = true,
	text_background_opacity = 1.0,
	hide_tab_bar_if_only_one_tab = true,
	color_scheme = "GitHub Dark",
	use_fancy_tab_bar = false,
	--window_background_opacity = 0.9,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = true,
}
