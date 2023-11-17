return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            vim.keymap.set("n", "<leader>tb", function()
                dap.toggle_breakpoint()
            end, { silent = true, noremap = true, desc = "Toggle breakpoint" })
            vim.keymap.set("n", "F5", function()
                dap.continue()
            end, { silent = true, noremap = true, desc = "DAP continue" })
        end,
    },

    {
        "leoluz/nvim-dap-go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        event = {
            "VeryLazy",
        },
        main = "dap-go",
        opts = {},
    },
}
