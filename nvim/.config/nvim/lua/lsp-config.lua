local map = require("map")

local nvim_lsp = require("plugin_loader").load("lspconfig")

if nvim_lsp ~= nil then
	--- @type lsp.ClientCapabilities
	local overrides = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
					commitCharactersSupport = true,
					preselectSupport = true,
					deprecatedSupport = true,
					insertReplaceSupport = true,
					labelDetailsSupport = true,
					tagSupport = {
						valueSet = {
							1, -- Deprecated
						}
					},
					resolveSupport = {
						properties = {
							"documentation",
							"detail",
							"additionalTextEdits",
							"sortText",
							"filterText",
							"insertText",
							"textEdit",
							"insertTextFormat",
							"insertTextMode",
						},
					},
					insertTextModeSupport = {
						valueSet = {
							1, -- asIs
							2, -- adjustIndentation
						}
					},
				},
				contextSupport = true,
				insertTextMode = 1,
				completionList = {
					itemDefaults = {
						"commitCharacters",
						"editRange",
						"insertTextFormat",
						"insertTextMode",
						"data",
					}
				},
			}
		}
	}
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true;
	-- capabilities = vim.tbl_deep_extend("force", capabilities, overrides)

	local cmp_nvim_lsp = require("plugin_loader").load("cmp_nvim_lsp")
	if cmp_nvim_lsp ~= nil then
		capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
	end

	local lsp_servers = {
		"clangd",
		"csharp_ls",
		--"cssls",
		-- "dartls",
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
		{ "html",        { "vscode-html-language-server", "--stdio" } },
		{ "cssls",       { "vscode-css-language-server", "--stdio" } },
		{ "jsonls",      { "vscode-json-language-server", "--stdio" } },
		{ "svelte",      { "svelteserver", "--stdio" } },
		{ "tailwindcss", { "tailwindcss-language-server", "--stdio" } },
		{ "ts_ls",       { "typescript-language-server", "--stdio" } }
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
		cmd = { "bunx", "--bun", "bash-language-server", "start" },
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

	-- formatting
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client ~= nil then
				if client.supports_method("textDocument/formatting") or
					client.supports_method("documentFormattingProvider") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						callback = function()
							-- filter in case many active clienst
							vim.lsp.buf.format({
								filter = function(buf_client)
									return buf_client.supports_method(
											"textDocument/formatting") or
										client.supports_method(
											"documentFormattingProvider")
								end
							})
						end,
						group = auto_group,
					})
				end
			end
		end,
		group = auto_group,
	})
end
