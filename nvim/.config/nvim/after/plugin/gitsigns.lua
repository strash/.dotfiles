local p = require("plugin_loader").load("gitsigns")

if p ~= nil then
	require("gitsigns").setup({})
end
