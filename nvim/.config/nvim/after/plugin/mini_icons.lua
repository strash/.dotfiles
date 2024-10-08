local p = require("plugin_loader").load("mini.icons")

if p ~= nil then
	require("mini.icons").setup()
	-- MiniIcons.mock_nvim_web_devicons()
end
