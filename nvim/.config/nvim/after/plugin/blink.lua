local p = require("plugin_loader").load("blink.cmp")

if p ~= nil then
	p.setup({
		keymap = {
			["<CR>"] = { "accept", "select_and_accept", "fallback" },
			["<C-f>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-k>"] = { "scroll_documentation_up", "fallback" },
			["<C-j>"] = { "scroll_documentation_down", "fallback" },
		},
		completion = {
			trigger = {
				show_on_x_blocked_trigger_characters = { "{", "}", ",", "(", ")" },
			},
			menu = {
				draw = {
					columns = { { "kind_icon" }, { "label" } },
					components = {
						kind_icon = {
							text = function(ctx)
								local icon, _, _ = MiniIcons.get("lsp", ctx.kind)
								return icon .. ctx.icon_gap
							end
						},
						label_description = {
							ellipsis = false,
							width = { max = 30 },
							text = function(ctx)
								if #ctx.label_description > 30 then
									---@type string
									local desc = ctx.label_description
									return desc:sub(0, 10) .. "…" .. desc:sub(#desc - 18, #desc)
								end
								return ctx.label_description
							end
						}
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				window = {
					min_width = 20,
					max_width = 80,
					max_height = 40,
				}
			},
		},
	})
end
