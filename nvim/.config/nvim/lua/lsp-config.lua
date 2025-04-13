-- all lsps
for _, server in ipairs({
	"clangd",
	"dartls",
	"dockerls",
	--"eslint",
	"gopls",
	"zls",
}) do
	vim.lsp.enable(server)
end

-- run node lsp servers with bun runtime
for _, server in ipairs({
	{ "bashls",      { "bash-language-server", "start" } },
	{ "cssls",       { "vscode-css-language-server", "--stdio" } },
	{ "html",        { "vscode-html-language-server", "--stdio" } },
	{ "jsonls",      { "vscode-json-language-server", "--stdio" } },
	{ "svelte",      { "svelteserver", "--stdio" } },
	{ "tailwindcss", { "tailwindcss-language-server", "--stdio" } },
	{ "ts_ls",       { "typescript-language-server", "--stdio" } },
	{ "yamlls",      { "yaml-language-server", "--stdio" } },
}) do
	vim.lsp.config(server[1], {
		cmd = vim.list_extend({ "bunx", "--bun" }, server[2]),
	})
	vim.lsp.enable(server[1])
end

-- lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", },
			telemetry = { enable = false, },
			window = {
				progressBar = false,
				statusBar = false,
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME }
			},
		},
	},
})
vim.lsp.enable("lua_ls")
