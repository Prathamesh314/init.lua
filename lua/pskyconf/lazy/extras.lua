return {
  -- vim-commentary plugin for commenting
  "tpope/vim-commentary",
  config = function()
    -- Keymaps for commenting
    vim.keymap.set('n', '<leader>cc', 'gcc', { desc = 'Comment current line' })
    vim.keymap.set('v', '<leader>cc', 'gc', { desc = 'Comment selected lines' })
  end,

}
