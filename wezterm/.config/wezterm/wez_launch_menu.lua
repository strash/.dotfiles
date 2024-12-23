local wez = require("wezterm")

local M = {}

local home = wez.home_dir

M.proj_dirs = {
	"Developer/APPDEV",
	"Developer/FOSS",
	"Developer/GAMEDEV",
	"Developer/RUST",
	"Developer/WEBDEV",
	"go/src/github.com/strash",
}

M.config = {
	launch_menu = {
		{
			label = ".dotfiles",
			cwd = home .. "/.dotfiles",
		},
	}
}

-- parse projects
for _, v in ipairs(M.proj_dirs) do
	local path_to_proj = home .. "/" .. v
	local i, proj = 0, {}
	local result = io.popen("find " .. path_to_proj .. " -type d -depth 1", "r")
	if result then
		for line in result:lines("*l") do
			i = i + 1
			proj[i] = line
		end
		result:close()
	end

	for _, p in ipairs(proj) do
		table.insert(M.config.launch_menu, {
			label = string.sub(p, #home + 2),
			cwd = p,
		})
	end
end

-- sort in alphabetical order
table.sort(M.config.launch_menu, function(a, b) return a.label < b.label end)

return M
