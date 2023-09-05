require("fzf-lua").setup({
	winopts = {
		width = 1.0,
		height = 1.0,
		preview = {
			horizontal = "right:50%",
		},
	},
	--files = {
	--	cmd = "find " .. vim.fn.getcwd() .. [[ -type f -not -path '*/\.git/*']],
	--},
})
