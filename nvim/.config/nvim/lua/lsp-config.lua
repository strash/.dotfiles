local nvim_lsp = require("plugin_loader").load("lspconfig")

if nvim_lsp ~= nil then
	local blink = require("plugin_loader").load("blink.cmp")
	local cmp_nvim_lsp = require("plugin_loader").load("cmp_nvim_lsp")

	--- @type lsp.ClientCapabilities
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true;

	if blink ~= nil then
		capabilities = blink.get_lsp_capabilities(capabilities)
	end

	if cmp_nvim_lsp ~= nil then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	local flags = {
		debounce_text_changes = 150,
	}

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
		"ocamllsp",
		--"tailwindcss",
		--"tsserver",
		--"svelte",
		"zls",
	}

	local node_lsp_servers = {
		{ "html",        { "vscode-html-language-server", "--stdio" } },
		{ "cssls",       { "vscode-css-language-server", "--stdio" } },
		{ "jsonls",      { "vscode-json-language-server", "--stdio" } },
		{ "svelte",      { "svelteserver", "--stdio" } },
		{ "tailwindcss", { "tailwindcss-language-server", "--stdio" } },
		{ "ts_ls",       { "typescript-language-server", "--stdio" } }
	}

	-- all lsps
	for _, server in ipairs(lsp_servers) do
		nvim_lsp[server].setup({
			capabilities = capabilities,
			flags = flags,
		})
	end

	-- run node lsp servers with bun runtime
	for _, server in ipairs(node_lsp_servers) do
		nvim_lsp[server[1]].setup({
			capabilities = capabilities,
			flags = flags,
			cmd = vim.list_extend({ "bunx", "--bun" }, server[2]),
		})
	end

	-- rust
	nvim_lsp.rust_analyzer.setup({
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
		capabilities = capabilities,
		flags = flags,
	})

	-- bashls
	nvim_lsp.bashls.setup({
		cmd = { "bunx", "--bun", "bash-language-server", "start" },
		cmd_env = {
			GLOB_PATTERN = "*@(.zsh|.sh|.inc|.bash|.command)",
		},
		filetypes = { "zsh", "sh" },
		root_dir = nvim_lsp.util.find_git_ancestor,
		single_file_support = true,
		capabilities = capabilities,
		flags = flags,
	})

	-- lua
	local runtime_path = vim.split(package.path, ";")
	local runtime_file = vim.api.nvim_get_runtime_file("", true)

	nvim_lsp.lua_ls.setup({
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
end
