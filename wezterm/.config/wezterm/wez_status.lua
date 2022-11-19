local wez = require("wezterm")
local UU = require("wez_util")
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
				--width = "Contain",
				--height = "Contain",
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
		--config.background[2]["source"]["File"] = home .. "/.config/wezterm/img/img_" .. wez.GLOBAL.background_image_idx .. ".jpg"
	end
	window:set_config_overrides(config)
	return false
end)

wez.on("update-status", function(window, pane)
	local date = wez.strftime(" %a %b %d ")
	local hours = wez.strftime("%H")
	local minutes = wez.strftime("%M ")
	--local seconds = wez.strftime("%S")

	window:set_right_status(wez.format({
		{ Background = { Color = EL.color.status.bg } },
		{ Foreground = { Color = EL.color.status.fg_date } },
		{ Text = date },
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = EL.color.status.fg_time } },
		{ Text = hours .. ":" .. minutes },
	}))

	--local m = tonumber(seconds)
	--if m % 5 == 0 then
	--	if wez.GLOBAL.background_image_current_minute ~= m then
	--		wez.GLOBAL.background_image_current_minute = m
	--		wez.GLOBAL.background_image_idx = UU.wrapi(wez.GLOBAL.background_image_idx + 1, 1, 314)
	--		wez.emit("change_background", window, pane)
	--	end
	--end
end)

return M
