local map, g = vim.api.nvim_set_keymap, vim.g
local options = { noremap = true, silent = true }

-- leader key
g.mapleader = " "

-- next buffer
map("n", "<Tab>", "<Cmd>bn<CR>", options)
-- previous buffer
map("n", "<S-Tab>", "<Cmd>bp<CR>", options)
-- delete buffer
map("n", "<leader>d", "<Cmd>bd<CR>", options)
-- nuke buffer
map("n", "<leader>w", "<Cmd>bw<CR>", options)
-- show all buffers
map("n", "<leader>l", "<Cmd>ls!<CR>", options)
-- open a file
map("n", "<leader>f", ":e **/", { noremap = true, silent = false })
-- toggle file tree
map("n", "<leader>n", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = false })
