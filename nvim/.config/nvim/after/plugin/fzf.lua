local p = require("plugin_loader").load("fzf-lua")

if p ~= nil then
	require("fzf-lua").setup({
		fzf_colors = true,
		winopts = {
			width = 1.0,
			height = 1.0,
			preview = {
				horizontal = "right:50%",
				vertical = "up:%50",
				layout = "vertical",
			},
		},
	})
end
