local p = require("plugin_loader").load("blink.cmp")

if p ~= nil then
	require("blink.cmp").setup({
		keymap = {
			["<CR>"] = { "accept", "select_and_accept", "fallback" },
			["<C-f>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-k>"] = { "scroll_documentation_up", "fallback" },
			["<C-j>"] = { "scroll_documentation_down", "fallback" },
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
	})
end
