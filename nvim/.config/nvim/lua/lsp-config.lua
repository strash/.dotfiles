-- LSP settings
local nvim_lsp = require("lspconfig")

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>nn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>so", [[<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>]], opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.ls.buf.list_workspace_folders()))<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  vim.cmd [[ command! Format execute "lua vim.lsp.buf.formatting()" ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
	"bashls",
	"cssls",
	--"dartls",
	"gdscript",
	"html",
	"jsonls",
	--"omnisharp",
	"prismals",
	"tsserver",
	--"vimls",
}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

-- dart
nvim_lsp.dartls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		allowAnalytics = false,
		closingLabels = true,
		devToolsBrowser = "default",
		enableServerSnippets = true,
		flutterHotReloadOnSave = "always",
		lineLength = 140,
		triggerSignatureHelpAutomatically = true,
	}
}

-- style lint
nvim_lsp.stylelint_lsp.setup {
	settings = {
		stylelintplus = {
			autoFixOnSave = true,
			validateOnSave = true,
		}
	}
}


local pid = vim.fn.getpid()
local omnisharp_bin = "/Users/strash/omnisharp-osx/run"
nvim_lsp.omnisharp.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}

