return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        lazy = true,
        config = function()
            require("lsp-zero.settings").preset({})
        end,
    },

    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "williamboman/mason-lspconfig.nvim" },
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
            },
        },
        config = function()
            local lsp = require("lsp-zero")

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.format_on_save({
                format_opts = {
                    async = false,
                    timeout_ms = 10000,
                },
                servers = {
                    ["null-ls"] = {
                        "javascript",
                        "typescript",
                        "lua",
                    },
                },
            })

            lsp.ensure_installed({
                "tsserver",
                "lua_ls",
            })

            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
            require("lspconfig").tsserver.setup({})

            lsp.setup()
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettier_eslint,
                },
            })
        end,
    },
}
