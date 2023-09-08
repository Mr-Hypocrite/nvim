return {

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
