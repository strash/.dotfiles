local p = require("plugin_loader").load("neogit")

if p ~= nil then
	require("neogit").setup({
		kind = "split",
		disable_commit_confirmation = true,
		disable_insert_on_commit = true,
	})
end
