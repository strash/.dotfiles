local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
	experimental = {
		ghost_text = true,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<TAB>"] = cmp.mapping.complete({ reason = "auto" }),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp", group_index = 1, priority = 3 },
		{ name = "luasnip",  group_index = 2, priority = 2 },
		{ name = "buffer",   group_index = 3, priority = 1 },
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	formatting = {
		format = function(entry, vim_item)
			if vim.tbl_contains({ 'path' }, entry.source.name) then
				local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
				if icon then
					vim_item.kind = icon
					vim_item.kind_hl_group = hl_group
					return vim_item
				end
			end
			return require('lspkind').cmp_format({ with_text = false })(entry, vim_item)
		end
	},
})
