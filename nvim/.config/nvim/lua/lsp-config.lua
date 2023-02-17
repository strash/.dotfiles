local nvim_lsp = require("lspconfig")
local map = require("map")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_servers = {
	"clangd",
	"csharp_ls",
	"cssls",
	"eslint",
	"html",
	"jsonls",
	"tsserver",
	--"gdscript",
	--"prismals",
	--"pylsp",
	--"sourcekit",
}

local flags = {
	debounce_text_changes = 150,
}

-- all lsps
for _, server in ipairs(lsp_servers) do
	nvim_lsp[server].setup({
		on_attach = map.set_lsp_map,
		capabilities = capabilities,
		flags = flags,
	})
end

-- rust
nvim_lsp.rust_analyzer.setup({
	on_attach = map.set_lsp_map,
	capabilities = capabilities,
	flags = flags,
	["rust-analyzer"] = {
		checkOnSave = {
			command = "clippy"
		},
		assist = {
			importGranularity = "module",
			importPrefix = "self",
		},
		cargo = {
			loadOutDirsFromCheck = true
		},
		procMacro = {
			enable = true
		},
	}
})

-- godot
nvim_lsp.gdscript.setup({
	cmd = { "nc", "localhost", "6008" },
	filetypes = { "gd", "gdscript", "gdscript3", "res", "tres", "shader", "godot" },
	root_dir = nvim_lsp.util.root_pattern("project.godot", ".git"),
	on_attach = map.set_lsp_map,
	capabilities = capabilities,
	flags = flags,
})

-- bashls
nvim_lsp.bashls.setup({
	cmd = { "bash-language-server", "start" },
	cmd_env = {
		GLOB_PATTERN = "*@(.zsh|.sh|.inc|.bash|.command)",
	},
	filetypes = { "zsh", "sh" },
	root_dir = nvim_lsp.util.find_git_ancestor,
	single_file_support = true,
	on_attach = map.set_lsp_map,
	capabilities = capabilities,
	flags = flags,
})

-- lua
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.lua_ls.setup({
	on_attach = map.set_lsp_map,
	capabilities = capabilities,
	flags = flags,
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
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

local auto_group = vim.api.nvim_create_augroup("LspAuGroup", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", },
	command = "EslintFixAll",
	group = auto_group,
})
