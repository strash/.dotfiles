local p = require("plugin_loader").load("blink.cmp")

if p ~= nil then
	require("blink.cmp").setup({
		keymap = {
			["<CR>"] = { "accept", "select_and_accept" },
			["<C-f>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<C-p>"] = { "select_prev" },
			["<C-n>"] = { "select_next" },
			["<C-k>"] = { "scroll_documentation_up" },
			["<C-j>"] = { "scroll_documentation_down" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<Tab>"] = {
				function(cmp)
					if cmp.is_in_snippet() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward", "fallback"
			},
		},
		trigger = {
			completion = {
				blocked_trigger_characters = { " ", "\n", "\t", "{", "}", "," },
			},
			signature_help = {
				enabled = true,
				show_on_insert_on_trigger_character = false,
			}
		},
		windows = {
			documentation = {
				max_width = 90,
				max_height = 40,
				auto_show = true,
				auto_show_delay_ms = 250,
			},
			ghost_text = {
				enabled = true,
			},
		},
		-- highlight = {
		-- 	use_nvim_cmp_as_default = true,
		-- },
		-- nerd_font_variant = "mono",
	})
end
