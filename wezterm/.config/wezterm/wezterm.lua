local wezterm = require("wezterm");

return {
	dpi = 144.0,
	font = wezterm.font("SF Mono", { weight = "Regular", italic = false }),
	font_size = 17.0,
	freetype_load_target = "Light",
	freetype_render_target = "HorizontalLcd",
	color_scheme = "GitHub Dark",
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	window_background_image = "./wallpappers/iu.jpeg",
	window_background_image_hsb = {
		brightness = 0.08,
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
}
