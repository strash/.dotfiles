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
require("plugins.cmp")
-- Everybody wants that line
require("plugins.that-line")
-- Telescope
require("plugins.telepoop")
-- Neogit
require("plugins.neogit")
-- buffer manager
require("buffer_manager").setup({
	width = 120,
	height = 12,
	focus_alternate_buffer = true,
})
