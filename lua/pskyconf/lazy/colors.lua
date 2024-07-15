function ColorMyPencil(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", {bg="none"})
    vim.api.nvim_set_hl(0, "NormalFloat", {bg="none"})
end


return {

    {
        "gruvbox-community/gruvbox",
        name = "gruvbox",
        config = function()
            vim.g.gruvbox_contrast_dark = "hard"
            vim.g.gruvbox_italic = false
            vim.g.gruvbox_invert_selection = '0'
            vim.cmd("colorscheme gruvbox")

            ColorMyPencil("gruvbox")
        end

    },

    {
        "altercation/vim-colors-solarized",
        name = "solarized",
        config = function()
            vim.g.solarized_termcolors = 256
            vim.g.solarized_italic_comments = false

            vim.cmd("colorscheme solarized")

            ColorMyPencil()
        end

    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                disable_background = false,
                styles = {
                    italic = false
                },
            })
            vim.cmd("colorscheme rose-pine")
            ColorMyPencil()
        end
    },
}

