local p = require("plugin_loader").load("flexoki")

if p ~= nil then
	p.setup({
		highlight_groups = {
			["StatusLine"] = { bg = "base", fg = "text" },
			["StatusLineNC"] = { bg = "base", fg = "muted" },
		},
	})
end
