local g = vim.g

g.nvim_tree_gitignore = 1
g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 0,
	folder_arrows = 1,
}
g.nvim_tree_highlight_opened_files = 1
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
}
g.nvim_tree_git_hl = 0
g.nvim_tree_quit_on_open = 1
g.nvim_tree_indent_markers = 0
g.nvim_tree_root_folder_modifier = ":~"
g.nvim_tree_add_trailing = 1
g.nvim_tree_group_empty = 0
g.nvim_tree_disable_window_picker = 1
g.nvim_tree_icon_padding = ""

require("nvim-tree").setup({
	update_cwd = true,
	diagnostics = {
		enable = true,
		icons = {
			hint = "H",
			info = "I",
			warning = "W",
			error = "E",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		width = 45,
	},
})



