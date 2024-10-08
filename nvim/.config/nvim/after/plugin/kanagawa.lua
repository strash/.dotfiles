-- kanagawa
-- { "rebelot/kanagawa.nvim" },
local p = require("plugin_loader").load("kanagawa")

if p ~= nil then
	require("kanagawa").setup({
		globalStatus = true,
		transparent = false,
		specialException = true,
		specialReturn = true,
		commentStyle = { italic = false },
		background = {
			dark = "dragon", -- wave, dragon
			light = "lotus", -- lotus
		},
	})
end
