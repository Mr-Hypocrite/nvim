return {
    {
        "dineshsalunke/poimandres.nvim",
        priority = 1000,
        config = function()
            require("poimandres").setup({
                disable_background = true,
                disable_float_background = true,
                groups = {
                    border = "blueGray1",
                },
            })
            vim.cmd.colorscheme("poimandres")
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1003,
        opts = {
            neotree = true,
        },
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
}
