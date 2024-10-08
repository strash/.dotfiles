local p = require("plugin_loader").load("ibl")

if p ~= nil then
	require("ibl").setup({
		indent = {
			char = "▏"
		},
		scope = {
			enabled = false,
			show_start = false,
			show_end = false,
		}
	})
end
