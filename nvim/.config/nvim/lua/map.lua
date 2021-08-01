local map, g = vim.api.nvim_set_keymap, vim.g
local silent = { silent = true }

-- leader key
g.mapleader = " "

-- next buffer
map("n", "<Tab>", "<Cmd>bn<CR>", silent)
-- previous buffer
map("n", "<S-Tab>", "<Cmd>bp<CR>", silent)
-- delete buffer
map("n", "<leader>d", "<Cmd>bd<CR>", silent)
-- nuke buffer
map("n", "<leader>w", "<Cmd>bw<CR>", silent)
-- show all buffers
map("n", "<leader>l", "<Cmd>ls!<CR>", silent)
-- open a file
map("n", "<leader>f", ":e **/", { silent = false })
-- toggle file tree
map("n", "<leader>n", "<Cmd>NvimTreeToggle<CR>", { silent = false })
