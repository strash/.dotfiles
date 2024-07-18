local cmp = require("cmp")
local lspkind = require('lspkind')

cmp.setup({
	view = {
		entries = "custom",
	},
	-- window = {
	-- 	completion = cmp.config.window.bordered {
	-- 		col_offset = -2,
	-- 		side_padding = 0,
	-- 		border = "rounded",
	-- 		winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
	-- 	},
	-- 	documentation = cmp.config.window.bordered {
	-- 		border = "rounded",
	-- 		winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
	-- 		max_width = 0
	-- 	},
	-- },
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
		{ name = "nvim_lsp", group_index = 1, priority = 30 },
		{ name = "path",     group_index = 1, priority = 20 },
		{ name = "buffer",   group_index = 2, priority = 10 },
	}),
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end
	},
	formatting = {
		expandable_indicator = false,
		fields = { "kind", "abbr" },
		format = lspkind.cmp_format({
			mode = "symbol",
			ellipsis_char = "…",
			show_labelDetails = true,
			before = function(entry, vim_item)
				if vim.tbl_contains({ "path" }, entry.source.name) then
					local icon, hl_group = MiniIcons.get("lsp", entry:get_completion_item().label)
					if icon then
						vim_item.kind = icon
						vim_item.kind_hl_group = hl_group
						return vim_item
					end
				end
				vim_item.menu = nil
				return vim_item
			end
		}),
	},
})
