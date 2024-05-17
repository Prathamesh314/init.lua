require("pskyconf.remap")
require("pskyconf.set")
require("pskyconf.lazy_init")

local augroup = vim.api.nvim_create_augroup
local ThePskyGroup = augroup("pskyconf", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

vim.filetype.add({
    extension={
        templ = "templ"
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 80,
        })
    end,
})

function YankHighlightedText()
    local start_line, start_col, end_line, end_col = unpack(vim.fn.getpos("'<")), unpack(vim.fn.getpos("'>"))
    vim.fn.setpos(".", {start_line, start_col, start_col, 0})
    vim.cmd("normal! y")
    vim.fn.setpos("'<", {start_line, start_col, start_col, 0})
    vim.fn.setpos("'>", {end_line, end_col, end_col, 0})
    vim.cmd("silent! !echo -n '" .. vim.fn.getreg("\"") .. "' | xclip -selection clipboard")
end


-- Define mappings for y and yy to yank highlighted text and entire block respectively
vim.api.nvim_set_keymap('n', 'y', '<cmd>lua YankHighlightedText()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'yy', 'yy', {noremap = true, silent = true})

autocmd('LspAttach', {
    group = ThePskyGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-d>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})


print("Hello from psyk conf")
