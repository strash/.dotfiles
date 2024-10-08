-- tokyonight
-- { "folke/tokyonight.nvim" },
local p = require("plugin_loader").load("tokyonight")

if p ~= nil then
	require("tokyonight").setup({
		style = "night", -- storm, moon, night
		light_style = "day",
		day_brightness = 0.25,
	})
end
