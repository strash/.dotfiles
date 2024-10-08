local p = require("plugin_loader").load("mini.indentscope")

if p ~= nil then
	require("mini.indentscope").setup({
		draw = {
			delay = 100,
			animation = require("mini.indentscope").gen_animation.none(),
			priority = 2,
		},
		mappings = {
			object_scope = "",
			object_scope_with_border = "",
			goto_top = "",
			goto_bottom = "",
		},
		options = {
			border = "both",
			indent_at_cursor = true,
			try_as_border = false,
		},
		--symbol = "╎",
		symbol = "⎸",
	})
end
