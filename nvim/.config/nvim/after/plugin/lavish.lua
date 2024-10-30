local p = require("plugin_loader").load("lavish")

if p ~= nil then
	require("lavish").setup({
		style = {
			italic_comments = true,
			transparent = true,
		},
	})
end
