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
	"gopls",
	"html",
	"jsonls",
	"sqlls",
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
--nvim_lsp.bashls.setup({
--	cmd = { "bash-language-server", "start" },
--	cmd_env = {
--		GLOB_PATTERN = "*@(.zsh|.sh|.inc|.bash|.command)",
--	},
--	filetypes = { "zsh", "sh" },
--	root_dir = nvim_lsp.util.find_git_ancestor,
--	single_file_support = true,
--	on_attach = map.set_lsp_map,
--	capabilities = capabilities,
--	flags = flags,
--})

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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- highlight references
		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd("CursorHold", {
				callback = function() vim.lsp.buf.document_highlight() end,
				group = auto_group,
			})
			vim.api.nvim_create_autocmd("CursorMoved", {
				callback = function() vim.lsp.buf.clear_references() end,
				group = auto_group,
			})
		end
		-- formatting
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function() vim.lsp.buf.format() end,
				group = auto_group,
			})
		end
	end,
})

--vim.api.nvim_create_autocmd("BufWritePre", {
--	pattern = { "*.tsx", "*.ts", "*.jsx", },
--	command = "EslintFixAll",
--	group = auto_group,
--})
