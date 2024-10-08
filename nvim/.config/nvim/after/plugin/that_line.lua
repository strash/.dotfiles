local p = require("plugin_loader").load("everybody-wants-that-line")

if p ~= nil then
	require("everybody-wants-that-line").setup({
		buffer = {
			prefix = "",
			symbol = "·",
		},
		prefix = " "
	})
end
