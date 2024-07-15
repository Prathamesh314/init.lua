return {

    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },

    "eandrju/cellular-automaton.nvim",
    -- Package manager
    "wbthomason/packer.nvim",
    -- nvim-tree file explorer
    {
        "kyazdani42/nvim-tree.lua",
        config = function()
            require('nvim-tree').setup {}
            -- Keybinding to toggle nvim-tree
            vim.api.nvim_set_keymap('n', '<leader>S', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
        end
    }
}
