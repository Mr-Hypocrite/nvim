return {
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (not jit.os:find("Windows"))
                and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
            or nil,
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        config = function(_, opts)
            local ls = require("luasnip")
            ls.setup({
                history = true,
                delete_check_events = "TextChanged",
            })
            require("luasnip.loaders.from_lua").load({ paths = "~/snippets" })
        end,
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        -- stylua: ignore
    },

    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "onsails/lspkind.nvim",
        },
        opts = function()
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local luasnip = require("luasnip")
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
                winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None",
            }
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end
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
                        before = function(entry, vim_item)
                            vim_item.menu = ({
                                nvim_lsp = "[LSP]",
                                buffer = "[Buffer]",
                            })[entry.source.name]
                            return vim_item
                        end,
                    }),
                },
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "buffer" },
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
