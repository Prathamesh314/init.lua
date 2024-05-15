vim.g.mapleader = " "

vim.keymap.set("n", "<leader>x", vim.cmd.Ex)

vim.keymap.set("i", "<C-c>", "<Esc>")

local opts = { noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'j', 'h', opts)
vim.api.nvim_set_keymap('n', 'k', 'k', opts)
vim.api.nvim_set_keymap('n', 'l', 'l', opts)
vim.api.nvim_set_keymap('n', 'm', 'j', opts)

vim.api.nvim_set_keymap('v', 'j', 'h', opts)
vim.api.nvim_set_keymap('v', 'k', 'k', opts)
vim.api.nvim_set_keymap('v', 'l', 'l', opts)
vim.api.nvim_set_keymap('v', 'm', 'j', opts)


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--greatest keymap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

--function to rename a current word
function RenameWord()
    local current_word = vim.fn.expand("<cword>")
    local new_name = vim.fn.input("Rename " ..current_word.." to: ")
    if new_name and #new_name>0 then
	local command = "%s/\\<"..current_word.."\\>/"..new_name.."/g"
	vim.cmd(command)
    end
end

vim.api.nvim_set_keymap("n", "<leader>r", ":lua RenameWord()<CR>",{noremap=true, silent=true})

--function to replace all occurances of a word in a buffer
function ReplaceWord()
    local current_word = vim.fn.expand("<cword>")
    local new_word = vim.fn.input("Rename: " ..current_word.. " with: ")

    if new_word and #new_word>0 then
    	current_word = vim.fn.escape(current_word, "\\")
	local command = ":%s/\\<" ..current_word.."\\>/" ..new_word.. "/g"
	vim.cmd(command)
    end
end

vim.keymap.set("n", "<leader>ra", ":lua ReplaceWord()<CR>", {noremap=true, silent=true})

vim.keymap.set("v", "y", "+y")
