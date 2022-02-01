local wezterm = require("wezterm");

return {
	dpi = 144.0,
	font = wezterm.font("SF Mono", { weight = "Regular", italic = false }),
	font_size = 17.0,
	forse_reverse_video_cursor = true,
	hide_tab_bar_if_only_one_tab = true,
	color_scheme = "GitHub Dark",
	use_fancy_tab_bar = false,
	window_background_image = "./wallpappers/iu.jpeg",
	window_background_image_hsb = {
		brightness = 0.08,
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	native_macos_fullscreen_mode = true,
	launch_menu = {
		{
			label = "DOTFILES",
			cwd = wezterm.home_dir .. "/.dotfiles",
			args = {"echo", wezterm.home_dir},
		},
		{
			label = "QMK",
			cwd = wezterm.home_dir .. "/.qmk_firmware",
			args = {"echo " .. wezterm.home_dir},
		},
		{
			label = "CHEVOSTIK APP",
			cwd = wezterm.home_dir .. "/APPDEV/chevostik_app",
		},
		{
			label = "TRAINING DIARY",
			cwd = wezterm.home_dir .. "/APPDEV/training_diary_flutter",
		},
	},
	keys = {
		{
			key = "h", mods = "ALT", action = "ShowLauncher",
		},
	},
}
