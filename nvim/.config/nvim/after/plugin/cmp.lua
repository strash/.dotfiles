local cmp = require("cmp")
local luasnip = require("luasnip")
local compare = require("cmp.config.compare")

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = true,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<TAB>"] = cmp.mapping.complete({ reason = "auto" }),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp",                group_index = 1, priority = 1 },
		{ name = "nvim_lsp_signature_help", group_index = 2, priority = 2 },
		{ name = "luasnip",                 group_index = 3, priority = 3 },
		{ name = "buffer",                  group_index = 4, priority = 4 },
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	sorting = {
		priority_weight = 1.0,
		comparators = {
			compare.exact,
			compare.locality,
			compare.recently_used,
			compare.score,
			compare.offset,
			compare.order,
			compare.kind,
		}
	}
})

--cmp.setup.cmdline("/", {
--	mapping = cmp.mapping.preset.cmdline(),
--	sources = {
--		{ name = "buffer", priority = 7 }
--	}
--})
