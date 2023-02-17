local wez = require("wezterm")
local UU = require("wez_util")
local A = wez.action

local M = {}

M.config = {
	disable_default_key_bindings = true,
	leader = { key = "b", mods = "CTRL", timeout_milliseconds = 10000 },
	keys = {
		-- reload config
		{ key = "r",     mods = "CMD",        action = A.ReloadConfiguration },
		-- launcher
		{ key = "s", mods = "LEADER", action = A.ShowLauncherArgs({
			flags = "LAUNCH_MENU_ITEMS",
			title = "- OPEN -",
		}) },
		-- panes
		{ key = "h",     mods = "LEADER",     action = A.ActivatePaneDirection("Left") },
		{ key = "l",     mods = "LEADER",     action = A.ActivatePaneDirection("Right") },
		{ key = "k",     mods = "LEADER",     action = A.ActivatePaneDirection("Up") },
		{ key = "j",     mods = "LEADER",     action = A.ActivatePaneDirection("Down") },
		{ key = "z",     mods = "LEADER",     action = A.TogglePaneZoomState },
		{ key = "x",     mods = "LEADER",     action = A.CloseCurrentPane({ confirm = true }) },
		-- tabs
		{ key = "t",     mods = "CMD",        action = A.SpawnTab("DefaultDomain") },
		{ key = "w",     mods = "CMD",        action = A.CloseCurrentTab({ confirm = true }) },
		{ key = "Tab",   mods = "CTRL",       action = A.ActivateTabRelative(1) },
		{ key = "Tab",   mods = "CTRL|SHIFT", action = A.ActivateTabRelative( -1) },
		-- windows
		{ key = "Enter", mods = "ALT",        action = A.ToggleFullScreen },
		{ key = "n",     mods = "CMD",        action = A.SpawnWindow },
		{ key = "q",     mods = "CMD",        action = A.QuitApplication },
		-- copy paste
		{ key = "c",     mods = "CMD",        action = A.CopyTo("Clipboard") },
		{ key = "v",     mods = "CMD",        action = A.PasteFrom("Clipboard") },
		-- font size
		{ key = "-",     mods = "CTRL",       action = A.DecreaseFontSize },
		{ key = "=",     mods = "CTRL",       action = A.IncreaseFontSize },
		{ key = "0",     mods = "CTRL",       action = A.ResetFontSize },
		-- actions
		{ key = "Space", mods = "LEADER",     action = A.QuickSelect },
		{ key = "c",     mods = "LEADER",     action = A.ActivateCopyMode },
		{ key = "f",     mods = "CMD",        action = A.Search("CurrentSelectionOrEmptyString") },
		{ key = "d",     mods = "LEADER",     action = A.ShowDebugOverlay },

		-- key table b
		{ key = "b",
			mods = "LEADER",
			action = A.ActivateKeyTable({
				name = "b",
				timeout_milliseconds = 10000,
				replace_current = true,
				one_shot = true,
			})
		},
		-- key table w (panes)
		{ key = "w",
			mods = "LEADER",
			action = A.ActivateKeyTable({
				name = "w",
				timeout_milliseconds = 10000,
				replace_current = true,
				one_shot = true,
			})
		},
	},
	-- key tables
	key_tables = {
		b = {
			-- tabs
			{ key = "h", action = A.MoveTabRelative( -1) },
			{ key = "l", action = A.MoveTabRelative(1) },
		},
		w = {
			-- panes
			{ key = "v", action = A.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
			{ key = "s", action = A.SplitVertical({ domain = "CurrentPaneDomain" }) },
			{ key = "w", action = A.PaneSelect },
			{ key = "r", action = A.RotatePanes("Clockwise") },
		},
	},
}

-- activate tab by index from 0 to 9
for i = 0, 9 do
	table.insert(M.config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = A.ActivateTab(UU.wrapi(i - 1, 0, 9))
	})
end

return M
