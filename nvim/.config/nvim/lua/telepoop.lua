local settings = {
	defaults = {
		sorting_strategy = "ascending",
		-- tiebreak = function(current_entry, existing_entry, prompt) return false end,
		selection_strategy = "reset",
		scroll_strategy = "cycle",
		layout_strategies = "horizontal",
		layout_config = {
			horizontal = {
				height = 0.8,
				preview_cutoff = 400,
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
		border = true,
		path_display = { "absolute" },
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		--get_status_text = function(picker) return "count / all" end
		hl_result_eol = true,
		dynamic_preview_title = false,
		history = false,
		cache_picker = false,
		preview = false,
		vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", },
		set_env = nil,
		color_devicons = false,
		-- mapping = {},
		-- default_mappings = {},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		prefilter_sorter = require("telescope.sorters").prefilter,
		file_ignore_patterns = { ".git/" },
		-- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		-- grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		-- qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
	--pickers = {},
	--extensions = {}
}

require("telescope").setup(settings)
