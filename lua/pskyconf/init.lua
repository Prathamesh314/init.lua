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

print("Hello from psyk conf")
