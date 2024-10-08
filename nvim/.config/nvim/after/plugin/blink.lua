local p = require("plugin_loader").load("blink.cmp")

if p ~= nil then
	require("blink.cmp").setup({
		keymap = {
			show = "<C-f>",
			accept = "<CR>",
			select_prev = { "<Up>", "<C-p>" },
			select_next = { "<Down>", "<C-n>" },
			scroll_documentation_up = "<C-k>",
			scroll_documentation_down = "<C-j>",
		},
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		nerd_font_variant = "mono",
		accept = {
			auto_brackets = {
				enabled = false
			}
		},
		trigger = {
			completion = {
				blocked_trigger_characters = { " ", "\n", "\t", "{", "}" },
			},
			signature_help = {
				enabled = true
			}
		},
		windows = {
			documentation = {
				max_width = 90,
				max_height = 47,
			},
		},
	})
end
