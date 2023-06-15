return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", },
        },
        keys = {
            { "<C-Space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" }
        },
        opts = {
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            ensure_installed = {
                "bash",
                "c",
                "html",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-Space>",
                    node_incremental = "<C-Space>",
                    scope_incremental = false,
                    node_decremental = "<bs>"
                }
            }
        }
    }
}
