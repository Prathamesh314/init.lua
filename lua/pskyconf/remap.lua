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

vim.keymap.set("n", "<Esc>", "<Nop>", {silent=true, noremap=true})
vim.keymap.set("i", "<Esc>", "<Nop>", {silent=true, noremap=true})


vim.keymap.set("n", "<C-j>", "<C-w>h", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-m>", "<C-w>j", opts)

-- Indent selected text with Tab
vim.api.nvim_set_keymap('v', '<Tab>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })


vim.api.nvim_set_keymap('i', '<Tab>', '<Tab>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })

-- removes highlight on the word after searching 
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':nohlsearch<CR>', { noremap = true, silent = true })


--cellular animation
vim.keymap.set("n", "<leader>cr", "<cmd>CellularAutomaton make_it_rain<CR>")
vim.keymap.set("n", "<leader>cg", "<cmd>CellularAutomaton game_of_life<CR>")

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


-- init.lua or a separate Lua configuration file

function wrap_selected_text(start_char, end_char)
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")

    -- Get the selected text
    local lines = vim.fn.getline(start_pos[2], end_pos[2])
    if #lines == 0 then return end

    -- Adjust the start and end positions for multiline selections
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])

    -- Join the lines and wrap them
    local selected_text = table.concat(lines, "\n")
    local wrapped_text = start_char .. selected_text .. end_char

    -- Replace the selected text with the wrapped text
    vim.fn.setreg('"', wrapped_text)
    vim.cmd('normal! gv""P')
end

-- Set key mappings in visual mode
vim.api.nvim_set_keymap('v', '{', ':lua wrap_selected_text("{", "}")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '(', ':lua wrap_selected_text("(", ")")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '[', ':lua wrap_selected_text("[", "]")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '"', ':lua wrap_selected_text(\'"\', \'"\')<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', "'", ':lua wrap_selected_text("\'", "\'")<CR>', { noremap = true, silent = true })
