local wez = require("wezterm")
local EL = require("wez_el")

local M = {}

local home = wez.home_dir
wez.GLOBAL.background_image_idx = wez.GLOBAL.background_image_idx or 1
wez.GLOBAL.background_image_current_time = wez.GLOBAL.background_image_current_time or 0

wez.on("change_background", function(window, _)
	local config = window:get_config_overrides() or {}
	if config.background == nil then
		config.background = {
			{
				source = { Color = "hsl:200 8 7" },
				width = "100%",
				height = "100%",
			},
			{
				source = { File = home .. "/.config/wezterm/img/img_" .. wez.GLOBAL.background_image_idx .. ".jpg" },
				attachment = "Fixed",
				opacity = 0.4,
				hsb = { hue = 1.0, saturation = 1.0, brightness = 0.3 },
				repeat_x = "NoRepeat",
				repeat_y = "NoRepeat",
				horizontal_align = "Center",
				vertical_align = "Middle",
			}
		}
	else
		config = nil
	end
	window:set_config_overrides(config)
	return false
end)

wez.on("update-status", function(window, _)
	local date = wez.strftime(" %a %b %d ")
	local hours = wez.strftime("%H")
	local minutes = wez.strftime("%M ")
	--local seconds = wez.strftime("%S")

	window:set_left_status(wez.format({
		{ Background = { Color = EL.color.status.bg } },
		{ Foreground = { Color = EL.color.status.fg_date } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = " STRASH " },
	}))

	window:set_right_status(wez.format({
		{ Background = { Color = EL.color.status.bg } },
		{ Foreground = { Color = EL.color.status.fg_date } },
		{ Text = date },
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = EL.color.status.fg_time } },
		{ Text = hours .. ":" .. minutes },
	}))
end)

return M
