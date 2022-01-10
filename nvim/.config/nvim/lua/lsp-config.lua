local nvim_lsp = require("lspconfig")
local map = require("map")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
	"cssls",
	--"csharp_ls",
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

-- bashls
nvim_lsp.bashls.setup {
	cmd = { "bash-language-server", "start" },
	cmd_env = {
		GLOB_PATTERN = "*@(.zsh|.sh|.inc|.bash|.command)",
	},
	filetypes = { "sh", "zsh" },
	root_dir = nvim_lsp.util.find_git_ancestor,
	single_file_support = true,
	on_attach = map.set_lsp_map,
	capabilities = capabilities,
	flags = flags,
}

-- omnisharp
nvim_lsp.omnisharp.setup{
	cmd = {
		"/Users/strash/.cache/omnisharp-vim/omnisharp-roslyn/run",
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
	},
	on_attach = map.set_lsp_map,
	capabilities = capabilities,
	flags = flags,
}

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

