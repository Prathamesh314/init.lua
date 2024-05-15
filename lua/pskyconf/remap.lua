vim.g.mapleader = " "

vim.keymap.set("n", "<leader>x", vim.cmd.Ex)

vim.keymap.set("i", "<C-c>", "<Esc>")

local opts = { noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'j', 'h', opts)
vim.api.nvim_set_keymap('n', 'k', 'k', opts)
vim.api.nvim_set_keymap('n', 'l', 'l', opts)
vim.api.nvim_set_keymap('n', 'm', 'j', opts)


