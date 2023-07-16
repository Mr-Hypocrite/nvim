return {
    {
        "L3MON4D3/LuaSnip",
        build = (not jit.os:find("Windows"))
                and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "mtoohey31/cmp-fish",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "onsails/lspkind.nvim",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local cmp = require("cmp")
            local border_opts = {
                border = {
                    { "╭", "CmpDocBorder" },
                    { "─", "CmpDocBorder" },
                    { "╮", "CmpDocBorder" },
                    { "│", "CmpDocBorder" },
                    { "╯", "CmpDocBorder" },
                    { "─", "CmpDocBorder" },
                    { "╰", "CmpDocBorder" },
                    { "│", "CmpDocBorder" },
                },
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            }
            return {
                formatting = {
                    fields = {
                        "abbr",
                        "kind",
                        "menu",
                    },
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 150,
                        ellipsis_char = "...",
                    }),
                },
                completion = {
                    keyword_length = 3,
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip", keyword_length = 3 },
                    { name = "buffer", keyword_length = 5 },
                    { name = "path" },
                }),
                window = {
                    scrollbar = false,
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
            }
        end,
    },

    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        "echasnovski/mini.surround",
        opts = {},
    },

    {
        "folke/zen-mode.nvim",
        keys = {
            {
                "<leader>zm",
                function()
                    require("zen-mode").toggle({
                        window = {
                            width = 0.85,
                        },
                    })
                end,
            },
        },
        opts = {
            plugins = {
                twilight = { enabled = true },
            },
        },
    },

    {
        "folke/twilight.nvim",
        opts = {},
    },
}
