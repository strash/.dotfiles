local cmp = require("cmp")

cmp.setup({
	-- snippet = {
	-- 	expand = function(args)
	-- 		vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
	-- 		-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	-- 		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
	-- 		-- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
	-- 	end,
	-- },
	mapping = {
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		-- { nam = 'vsnip' }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	})
})

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" }
	}
})

-- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
-- 	sources = cmp.config.sources({
-- 		{ name = 'path' }
-- 	}, {
-- 		{ name = 'cmdline' }
-- 	})
-- })




-- require'compe'.setup {
-- 	enabled = true;
-- 	autocomplete = true;
-- 	debug = false;
-- 	min_length = 1;
-- 	preselect = 'enable';
-- 	throttle_time = 80;
-- 	source_timeout = 200;
-- 	incomplete_delay = 400;
-- 	max_abbr_width = 100;
-- 	max_kind_width = 100;
-- 	max_menu_width = 100;
-- 	documentation = true;
-- 
-- 	source = {
-- 		path = true;
-- 		nvim_lsp = true;
-- 	};
-- }
-- 
-- local t = function(str)
-- 	return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- 
-- local check_back_space = function()
-- 	local col = vim.fn.col('.') - 1
-- 	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end
-- 
-- -- Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
-- 	if vim.fn.pumvisible() == 1 then
-- 		return t "<C-n>"
-- 	elseif check_back_space() then
-- 		return t "<Tab>"
-- 	else
-- 		return vim.fn['compe#complete']()
-- 	end
-- end
-- 
-- _G.s_tab_complete = function()
-- 	if vim.fn.pumvisible() == 1 then
-- 		return t "<C-p>"
-- 	else
-- 		return t "<S-Tab>"
-- 	end
-- end
-- 
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
