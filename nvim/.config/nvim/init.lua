-- Plugins
require("plugins")
-- Settings
require("settings")
-- Key mapping
require("map")
-- LSP setup
require("lsp-config")
-- Treesitter config
require("treeshitter-config")
-- Compe config
require("compe-config")
-- Status line
require("statusline")
-- Tree view
require("tree")
-- Flutter tools
require("flutter-tools").setup{
	closing_tags = {
		highlight = "NonText", -- highlight for the closing tag
		prefix = "- ", -- character to use for close tag e.g. > Widget
		enabled = true -- set to false to disable
	},
}
