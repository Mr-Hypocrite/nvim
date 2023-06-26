return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false,
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects" },
        },
        keys = {
            { "<C-Space>", desc = "Increment selection" },
            { "<bs>", desc = "Decrement selection", mode = "x" },
        },
        cmd = { "TSUpdateSync" },
        opts = {
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            ensure_installed = {
                "bash",
                "fish",
                "c",
                "html",
                "fish",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
                "dockerfile",
                "http",
                "go",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-Space>",
                    node_incremental = "<C-Space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
    },

    {
        "windwp/nvim-ts-autotag",
        opts = {
            enable_rename = true,
            enable_close = true,
            enable_close_on_slash = true,
        },
    },
}
