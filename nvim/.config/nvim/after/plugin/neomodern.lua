-- neomodern
-- { "cdmill/neomodern.nvim" },
local p = require("plugin_loader").load("neomodern")

if p ~= nil then
	require("neomodern").setup()
end
