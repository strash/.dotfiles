local wez = require("wezterm")
local EL = require("wez_el")
local UU = require("wez_util")
local LM = require("wez_launch_menu")
local KM = require("wez_map")
require("wez_status")
require("wez_tab")

local M = {}

-- launch menu
UU.merge_config(LM, M)
-- mappings
UU.merge_config(KM, M)

-- font
local font_family = "Iosevka Term SS17"
M.font_size = 15.0
M.line_height = 1.05
M.text_blink_rate = 0
M.text_blink_rate_rapid = 0
M.text_background_opacity = 1.0
M.font = wez.font({ family = font_family, italic = false })
--M.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
M.font_rules = {
	{
		intensity = "Normal",
		italic = true,
		font = wez.font({ family = font_family, weight = "Regular" })
	},
}

-- tabbar
M.hide_tab_bar_if_only_one_tab = false
M.use_fancy_tab_bar = false
M.tab_bar_at_bottom = true
M.tab_max_width = 20
M.status_update_interval = 10000

-- window
M.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
M.window_close_confirmation = "NeverPrompt"
M.force_reverse_video_cursor = false
M.native_macos_fullscreen_mode = true
M.show_update_window = false
M.exit_behavior = "Hold"
M.window_background_opacity = 1.0
M.default_cwd = wez.home_dir .. "/.dotfiles"

-- colorscheme
--M.color_scheme = "GitHub Dark"
M.colors = {
	tab_bar = {
		background = EL.color.tab_bg,
		inactive_tab_edge = EL.color.tab.bg.active,
		new_tab = {
			bg_color = EL.color.new_tab.bg,
			fg_color = EL.color.new_tab.fg,
		},
	},
}

-- panes
M.inactive_pane_hsb = {
	brightness = 1.0,
}

M.alternate_buffer_wheel_scroll_speed = 1

return M
