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

vim.keymap.set("n", "<leader>v", ":vsplit()<CR>", {noremap=true, silent=true})
vim.keymap.set("n", "<leader>h", ":split()<CR>", {noremap=true, silent=true})

vim.keymap.set("n", "<C-j>", "<C-w>h", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-m>", "<C-w>j", opts)

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


--function to replace x number of same words below current word
function ReplaceBelow()
    local current_word = vim.fn.expand("<cword>")
    local new_word = vim.fn.input("Replace " ..current_word.. " with: ")
    local number = tonumber(vim.fn.input("Number of occurences to replace: "))
    if new_word and #new_word > 0 and number then
        current_word = vim.fn.escape(current_word, "\\")

        for _=1, number do
            local command = ".,$s/\\<" ..current_word.. "\\>/" ..new_word.. "/"
            vim.cmd(command)
        end
    end
end

vim.keymap.set("n", "<leader>rb", ":lua ReplaceBelow()<CR>", {noremap=true, silent=true})
-- Define a mapping for opening a terminal
vim.api.nvim_set_keymap('n', '<leader>T', ':terminal<CR>', {noremap = true})

-- Define a function to comment the current word
function CommentCurrentWord()
    vim.api.nvim_command('normal! ^')  -- Move to the beginning of the word
    vim.api.nvim_command('normal! v')  -- Enter visual mode
    vim.api.nvim_command('normal! e')  -- Move to the end of the word
    vim.api.nvim_command('silent! CommentToggle') -- Comment the selected text
end


-- Define mappings for commenting current word and selected block
vim.api.nvim_set_keymap('n', 'gc', '<cmd>lua CommentCurrentWord()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('x', 'gcc', ':CommentToggle<CR>', {noremap = true, silent = true})
