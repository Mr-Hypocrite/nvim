return {

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1003,
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
}
