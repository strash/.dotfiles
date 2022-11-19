local treeshitter_context = require("treesitter-context")

treeshitter_context.setup({
	enable = true,
	max_lines = 0,
	trim_scope = "outer",
	min_window_height = 0,
	patterns = {
		default = {
			"class",
			"function",
			"method",
			"for",
			"while",
			"if",
			"switch",
			"case",
		},
	},
	separator = "∙",
})
