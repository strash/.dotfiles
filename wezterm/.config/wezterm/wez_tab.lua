local wez = require("wezterm")
local EL = require("wez_el")
local M = {}

local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

local unescape = function(url)
  return url:gsub("%%(%x%x)", hex_to_char)
end

function M.get_cwd(tab)
	return unescape(tab.active_pane.current_working_dir:match("[^/]+$"):upper())
end

function M.get_zoom(tab)
	if tab.active_pane.is_zoomed then
		return EL.el.zoom
	end
	return EL.el.none
end

wez.on("format-tab-title", function(tab, _, _, config, _, _) -- (tab, tabs, panes, config, hover, max_width)
	local tab_max_width = config.tab_max_width or 16
	local cwd = M.get_cwd(tab)
	local zoom = M.get_zoom(tab)
	local title = EL.el.space .. cwd .. zoom .. EL.el.space
	local truncate = EL.el.none

	if #title > tab_max_width then
		truncate = EL.el.truncate
		cwd = wez.truncate_right(cwd, tab_max_width - #zoom - #EL.el.space * 3)
	elseif #title < tab_max_width then
		cwd = wez.pad_right(cwd, tab_max_width - #zoom - #EL.el.space * 2)
	end

	local tab_title = {
		-- cwd
		{ Background = { Color = tab.is_active and EL.color.tab.bg.active or EL.color.tab.bg.inactive } },
		{ Foreground = { Color = tab.is_active and EL.color.tab.fg.active or EL.color.tab.fg.inactive } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = EL.el.space .. cwd },
		-- truncate char
		{ Foreground = { Color = tab.is_active and EL.color.tab.fg_truncate.active or EL.color.tab.fg_truncate.inactive } },
		{ Attribute = { Intensity = "Normal" } },
		{ Text = truncate },
		-- zoom char
		{ Foreground = { Color = tab.is_active and EL.color.tab.fg_zoom.active or EL.color.tab.fg_zoom.inactive } },
		{ Text = zoom .. EL.el.space },
	}

	return tab_title
end)

return M
