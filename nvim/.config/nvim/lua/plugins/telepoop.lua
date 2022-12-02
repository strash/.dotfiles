local settings = {
	defaults = {
		sorting_strategy = "ascending",
		selection_strategy = "reset",
		scroll_strategy = "cycle",
		layout_strategies = "horizontal",
		layout_config = {
			horizontal = {
				height = 0.8,
				prompt_position = "top",
				width = 0.5
 			},
		},
		winblend = 0,
		prompt_prefix = " ",
		selection_caret = "> ",
		entry_prefix = "  ",
		multi_icon = "+ ",
		initial_mode = "insert",
		path_display = { "absolute" },
		hl_result_eol = true,
		dynamic_preview_title = false,
		history = false,
		cache_picker = false,
		preview = false,
		set_env = nil,
		color_devicons = false,
		--file_sorter = require("telescope.sorters").get_fuzzy_file,
		--generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		--prefilter_sorter = require("telescope.sorters").prefilter,
		file_ignore_patterns = {
			".DS_Store",
			".git/",
			".import/",
			".godot/",
			".android/build/",
			"node_modules/",
			"dist/",
			"prisma/migrations/",
			"target/",
			"mini.nvim",
		},
		pickers = {
			buffers = {
				mappings = {
					i = {
						["<C-d>"] = require("telescope.actions").delete_buffer,
					},
				}
			},
		}
	},
}

require("telescope").setup(settings)
