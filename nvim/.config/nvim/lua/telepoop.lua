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
				width = 0.6
			},
		},
		winblend = 10,
		prompt_prefix = "/ ",
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
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		prefilter_sorter = require("telescope.sorters").prefilter,
		file_ignore_patterns = { ".git/", "node_modules/" },
		--mappings = {
		--	n = {
		--		["<C-m>"] = require("telescope.actions").toggle_selection,
		--		["<CR>"] = require("telescope.actions.set").edit,
		--	},
		--	i = {
		--		["<C-m>"] = require("telescope.actions").toggle_selection,
		--		["<C-CR>"] = require("telescope.actions.set").edit,
		--	},
		--},
  },
}

require("telescope").setup(settings)
