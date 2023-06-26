return {
    {
        "dineshsalunke/poimandres.nvim",
        priority = 1000,
        opts = {
            disable_italics = true,
        },
        config = function()
            require("poimandres").setup({
                groups = {
                    border = "blueGray1",
                },
            })
            vim.cmd.colorscheme("poimandres")
        end,
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1001,
        opts = {},
        config = function()
            -- vim.cmd.colorscheme("tokyonight-night")
        end,
    },
}
