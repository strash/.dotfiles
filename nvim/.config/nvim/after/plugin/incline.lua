local p = require("plugin_loader").load("incline")

if p ~= nil then
	require("incline").setup()
end
