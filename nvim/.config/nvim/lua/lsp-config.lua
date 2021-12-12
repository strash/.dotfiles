local nvim_lsp = require("lspconfig")
local map = require("map")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
	"bashls",
	"cssls",
	"csharp_ls",
	"gdscript",
	"html",
	"jsonls",
	"prismals",
	"pylsp",
	"tsserver",
}

local flags = {
	debounce_text_changes = 150,
}

-- all lsps
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = map.set_lsp_map,
		capabilities = capabilities,
		flags = flags,
	}
end

-- flutter
require("flutter-tools").setup {
	closing_tags = {
		highlight = "NonText",
		prefix = "- ",
		enabled = true
	},
	lsp = {
		on_attach = map.set_lsp_map,
		capabilities = capabilities,
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
		}
	}
}

-- sumneko lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

