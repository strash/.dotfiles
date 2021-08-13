local g = vim.g

g.nvim_tree_width = 40
g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
g.nvim_tree_gitignore = 1
g.nvim_tree_auto_open = 0
g.nvim_tree_auto_close = 0
--g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }
g.nvim_tree_quit_on_open = 1
g.nvim_tree_follow = 0
g.nvim_tree_indent_markers = 0
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_git_hl = 0
g.nvim_tree_highlight_opened_files = 1
-- This is the default. See :help filename-modifiers for more options
g.nvim_tree_root_folder_modifier = ":~"
g.nvim_tree_tab_open = 1
g.nvim_tree_auto_resize = 1
g.nvim_tree_disable_netrw = 0
g.nvim_tree_hijack_netrw = 1
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 0
-- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
g.nvim_tree_lsp_diagnostics = 1
g.nvim_tree_disable_window_picker = 0
g.nvim_tree_hijack_cursor = 0
g.nvim_tree_icon_padding = ""
g.nvim_tree_update_cwd = 1
--g.nvim_tree_window_picker_exclude = { "filetype": { "packer", "qf" }, "buftype": { "terminal" } }


-- List of filenames that gets highlighted with NvimTreeSpecialFile
--g.nvim_tree_special_files = { "README.md" = 1, "Makefile" = 1, "MAKEFILE" = 1, }
g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1, folder_arrows = 1, }

g.nvim_tree_icons = {
	default = "",
	symlink = "⧁",
	git = {
		unstaged = "⊗",
		staged = "✓",
		unmerged = "⊘",
		renamed = "➜",
		untracked = "⊕",
		deleted = "⊖",
		ignored = "◌"
	},
	folder = {
		arrow_open = "↳",
		arrow_closed = "→",
		default = "",
		open = "",
		empty = "",
		empty_open = "",
		symlink = "⧁ ",
		symlink_open = "⧁ ",
	},
	lsp = {
		hint = "H",
		info = "I",
		warning = "W",
		error = "E",
	}
}


