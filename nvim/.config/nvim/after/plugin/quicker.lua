local p = require("plugin_loader").load("quicker")

local important_sign = "→"
local not_important_sign = "•"

if p ~= nil then
	p.setup({
		edit = {
			autosave = true
		},
		type_icons = {
			E = important_sign,
			W = important_sign,
			H = not_important_sign,
			I = not_important_sign,
			N = not_important_sign,
		},
	})
end
