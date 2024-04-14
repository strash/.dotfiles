local nvim_lsp = require("lspconfig")
local map = require("map")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.default_capabilities(client_capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_servers = {
	"clangd",
	"csharp_ls",
	--"cssls",
	"dartls",
	"dockerls",
	--"eslint",
	"gopls",
	--"html",
	--"jsonls",
	--"tailwindcss",
	--"tsserver",
	--"svelte",
}

local node_lsp_servers = {
	{ "cssls",       { "vscode-css-language-server", "--stdio" } },
	{ "html",        { "ngserver", "--stdio", "--tsProbeLocations", "", "--ngProbeLocations", "" } },
	{ "jsonls",      { "vscode-json-language-server", "--stdio" } },
	{ "svelte",      { "svelte-language-server", "--stdio" } },
	{ "tailwindcss", { "tailwindcss-language-server", "--stdio" } },
	{ "tsserver",    { "typescript-language-server", "--stdio" } }
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

-- run node lsp servers with bun runtime
for _, server in ipairs(node_lsp_servers) do
	nvim_lsp[server[1]].setup({
		on_attach = map.set_lsp_map,
		capabilities = capabilities,
		flags = flags,
		cmd = vim.list_extend({ "bunx", "--bun" }, server[2]),
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
local runtime_file = vim.api.nvim_get_runtime_file("", true)
local idxs = {}
for i, v in ipairs(runtime_file) do
	if v:find("everybody-wants-that-line.nvim", 0, true) or v:match(".local/share/nvim/site$") then
		table.insert(idxs, i)
	end
end
for i = #idxs, 1, -1 do
	table.remove(runtime_file, idxs[i])
end
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.lua_ls.setup({
	on_attach = map.set_lsp_map,
	capabilities = capabilities,
	flags = flags,
	settings = {
		Lua = {
			completion = {
				callSnippet = "Both",
			},
			diagnostics = {
				globals = { "vim" },
			},
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			telemetry = {
				enable = false,
			},
			window = {
				progressBar = false,
				statusBar = false,
			},
			workspace = {
				library = runtime_file,
				checkThirdParty = false,
			},
		},
	},
})

local auto_group = vim.api.nvim_create_augroup("LspAuGroup", { clear = true })

local function filter_format_client(client)
	return client.server_capabilities.documentFormattingProvider
end

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		local lsp_clients = vim.lsp.get_active_clients()
		local filename = vim.api.nvim_buf_get_name(args.buf)
		local f = filename:match("[^.]+$") or ""
		local can_format = false
		for _, client in ipairs(lsp_clients) do
			if can_format == true then
				break
			end
			for _, value in ipairs(client.config.filetypes) do
				if value == f then
					can_format = true
					break
				end
			end
		end
		-- filter in case many active clienst
		if can_format then
			vim.lsp.buf.format({ filter = filter_format_client })
		end
	end,
	group = auto_group,
})
