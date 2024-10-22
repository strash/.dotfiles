local p = require("plugin_loader").load("flutter-tools")

if p ~= nil then
	local map = require("map")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true;

	require("flutter-tools").setup({
		ui = {
			border = "rounded",
			notification_style = 'native'
		},
		debugger = {
			enabled = false,
		},
		flutter_path = "/Users/strash/Developer/flutter/bin/flutter",
		widget_guides = {
			enabled = false,
		},
		closing_tags = {
			enabled = false
		},
		dev_log = {
			enabled = true,
			notify_errors = false,
			open_cmd = "split_f", -- command to use to open the log buffer
		},
		lsp = {
			on_attach = map.set_lsp_map,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 150,
			},
			settings = {
				lineLength = 80,
				renameFilesWithClasses = "always",
				documentation = "full",
			}
		}
	})
end
