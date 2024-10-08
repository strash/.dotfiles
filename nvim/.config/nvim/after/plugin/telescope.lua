local p = require("plugin_loader").load("telescope")

if p ~= nil then
	require("telescope").setup({
		defaults = {
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = {
					height = 0.8,
					prompt_position = "top",
					width = 0.5
				},
			},
			prompt_prefix = " ",
			path_display = { "absolute" },
			history = false,
			cache_picker = false,
			preview = false,
			color_devicons = false,
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
				"obj/",
				"bin/",
			},
		},
	})
end
