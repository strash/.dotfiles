require("oil").setup({
	columns = {
	},
	view_options = {
		show_hidden = true,
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
