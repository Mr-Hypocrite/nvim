return {

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1003,
        opts = {
            neotree = true,
        },
        config = function()
            require("catppuccin").setup({
                transparent_background = true
            })
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
}
