require("everybody-wants-that-line").setup({
	buffer = {
		show = true,
		prefix = "B:",
		symbol = "0",
		max_symbols = 5,
	},
	filepath = {
		path = "relative",
		shorten = false,
	},
	filesize = {
		metric = "decimal"
	},
	separator = "│",
})
