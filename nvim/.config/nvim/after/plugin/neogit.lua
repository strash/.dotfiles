local M = require("neogit")

M.setup({
	kind = "split",
	disable_commit_confirmation = true,
	disable_insert_on_commit = true,
})

return M
