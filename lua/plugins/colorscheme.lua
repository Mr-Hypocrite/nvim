return {
    {
        "dineshsalunke/poimandres.nvim",
        priority = 1000,
        opts = {},
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {},
        config = function()
            vim.cmd.colorscheme("rose-pine")
        end,
    },
}
