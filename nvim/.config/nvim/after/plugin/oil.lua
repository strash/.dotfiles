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
	float = {
		padding = 10,
		max_width = 120,
		max_height = 25,
		border = "rounded",
		win_options = {
			winblend = 0,
		},
		override = function(opts)
			opts["zindex"] = 1000
			return opts
		end
	},
	progress = {
		width = 100,
		height = 12,
		win_options = {
			winblend = 0,
		},
	},
})
