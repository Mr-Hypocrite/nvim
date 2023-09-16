return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    {
        "rest-nvim/rest.nvim",
        opts = {},
        keys = {
            {
                "<leader>rt",
                function()
                    require("rest-nvim").run()
                end,
                desc = "Run the rest request in the current buffer",
            },
        },
    },

    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow",
    },

    {
        "norcalli/nvim-colorizer.lua",
        opts = { "*" },
    },
}
