local p = require("plugin_loader").load("oil")

if p ~= nil then
	require("oil").setup({
		default_file_explorer = true,
		columns = {
			"icon",
			--"size",
		},
		win_options = {
			signcolumn = "auto",
		},
		lsp_file_methods = {
			autosave_changes = true,
		},
		view_options = {
			show_hidden = true,
			natural_order = true,
		},
		-- progress = {
		-- 	width = 100,
		-- 	height = 12,
		-- 	win_options = {
		-- 		winblend = 0,
		-- 	},
		-- },
		-- watch_for_changes = true,
	})
end
