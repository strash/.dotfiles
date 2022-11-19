local M = {}

M.el = {
	none = "",
	space = " ",
	truncate = "<",
	zoom = "Z",
}

M.color = {
	tab_bg = "#393C40",
	new_tab = {
		bg = "#393C40",
		fg = "#ACB4BF",
	},
	tab = {
		bg = {
			active = "#212326",
			inactive = "#393C40",
		},
		fg = {
			active = "#ACB4BF",
			inactive = "#8A9099",
		},
		fg_zoom = {
			active = "#60BF6F",
			inactive = "#548C5D",
		},
		fg_truncate = {
			active = "#676D73",
			inactive = "#575C61",
		},
	},
	status = {
		bg = "#212326",
		fg_date = "#548C5D",
		fg_time = "#60BF6F",
	}
}

return M
