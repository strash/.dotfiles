require("everybody-wants-that-line").setup({
	buffer = {
		show = true,
		prefix = "",
		symbol = "0",
		max_symbols = 5,
	},
	filepath = {
		path = "relative", -- tail, relative, full
		shorten = false,
	},
	filesize = {
		metric = "decimal"
	},
	separator = "│",
})
