-- leader key
vim.g.mapleader = " "

-- buffers
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [[*+y]])
-- Bind YY to yank the entire line to clipboard
vim.api.nvim_set_keymap('n', 'YY', '"+yy', { noremap = true, silent = true })

-- Bind Y in visual mode to yank the selected text to clipboard
vim.api.nvim_set_keymap('v', 'Y', '"+y', { noremap = true, silent = true })

-- save
vim.keymap.set("n", "<leader>s", ":w<cr>")
