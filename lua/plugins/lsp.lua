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
            "folke/neodev.nvim",
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
                lsp.default_keymaps({ buffer = bufnr, preserve_mappings = false })
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
                        "typescriptreact",
                        "lua",
                    },
                },
            })

            lsp.ensure_installed({
                "tsserver",
                "lua_ls",
            })

            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

            lsp.setup()
        end,
    },
    {
        "jose-elias-alvarez/typescript.nvim",
        config = function()
            require("typescript").setup({})
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                debug = true,
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.eslint_d,
                    require("typescript.extensions.null-ls.code-actions"),
                },
            })
        end,
    },

    {
        "folke/neodev.nvim",
        opts = {},
        config = function()
            require("neodev").setup()
        end,
    },
}
