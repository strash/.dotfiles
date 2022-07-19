require("everybody-wants-that-line").setup({
	buffer = {
		show = true,
		prefix = "b",
		symbol = "0",
		max_symbols = 5,
	},
	filepath = {
		path = "relative",
		shorten = false,
	},
	filesize = {
		metric = "decimal",
	},
	separator = "│",
})
