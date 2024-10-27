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
			show_documentation = "<C-h>",
			hide_documentation = "<C-h>",
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
				blocked_trigger_characters = { " ", "\n", "\t", "{", "}", "," },
				show_on_insert_blocked_trigger_characters = { "'", '"', "(" },
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
