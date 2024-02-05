return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        cmd = { "TSUpadateSync" },
        opts = function()
            return {
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enabled = true,
                },
                ensure_installed = {
                    "bash",
                    "fish",
                    "html",
                    "javascript",
                    "typescript",
                    "tsx",
                    "json",
                    "lua",
                    "vim",
                    "vimdoc",
                    "yaml",
                    "dockerfile",
                    "go",
                    "rust",
                    "css",
                    "proto",
                },
            }
        end,
    },

    -- Completetion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
        },
        event = "InsertEnter",
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
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
            return {
                completion = { completeopt = "menu,menuone,noselect" },
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
                    ["<C-p>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            cmp.mapping.close()
                        end
                    end, { "i", "s" }),
                    ["<C-n>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            cmp.mapping.close()
                        end
                    end, { "i", "s" }),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.SelectBehavior.Replace, select = false }),
                }),
                sources = cmp.config.sources({
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                }, {
                    { name = "path" },
                    { name = "buffer" },
                }),
                window = {
                    completion = cmp.config.window.bordered(border_opts),
                    documentation = cmp.config.window.bordered(border_opts),
                },
            }
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = false,
        config = function()
            require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
        end,
    },

    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", "VonHeikemen/lsp-zero.nvim" },
        opts = {},
        config = function(_, config)
            local tstools = require("typescript-tools")
            tstools.setup(config)
            vim.keymap.set("n", "<leader>toi", "<CMD>TSToolsOrganizeImports<CR>")
            vim.keymap.set("n", "<leader>tsi", "<CDM>TSToolsSortImports<CR>")
            vim.keymap.set("n", "<leader>tai", "<CDM>TSToolsAddMissingImports<CR>")
            vim.keymap.set("n", "<leader>tfa", "<CMD>TSToolsFixAll<CR>")
        end,
    },

    -- Lsp
    {
        "neovim/nvim-lspconfig",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        lazy = true,
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            local lspconfig = require("lspconfig")

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame" })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
                vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
                vim.keymap.set(
                    "n",
                    "<leader>gr",
                    require("telescope.builtin").lsp_references,
                    { desc = "[G]oto [R]eference" }
                )
                vim.keymap.set("n", "<leader>gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Hover Documentation" })
            end)
            lsp_zero.setup_servers({ "rust_analyzer", "gopls", "bufls", "phpactor" })

            lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
        end,
    },

    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        opts = function()
            return {}
        end,
    },

    {
        "mhartington/formatter.nvim",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        config = function()
            local formatter = require("formatter")
            formatter.setup({
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {
                        require("formatter.filetypes.lua").stylua,
                    },
                    typescript = {
                        require("formatter.filetypes.typescript").prettierd,
                        require("formatter.filetypes.typescript").eslint_d,
                    },
                    typescriptreact = {
                        require("formatter.filetypes.typescript").prettierd,
                        require("formatter.filetypes.typescript").eslint_d,
                    },
                    javascript = {
                        require("formatter.filetypes.typescript").prettierd,
                        require("formatter.filetypes.typescript").eslint_d,
                    },
                    javascriptreact = {
                        require("formatter.filetypes.typescript").prettierd,
                        require("formatter.filetypes.typescript").eslint_d,
                    },
                    json = {
                        require("formatter.filetypes.json").prettierd,
                    },
                    jsonc = {
                        require("formatter.filetypes.json").prettierd,
                    },
                    go = {
                        require("formatter.filetypes.go").gofmt,
                        require("formatter.filetypes.go").goimports,
                        require("formatter.filetypes.go").golines,
                    },
                    php = {
                        require("formatter.filetypes.php").phpcbf,
                        require("formatter.filetypes.php").php_cs_fixer,
                    },
                },
            })
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
                callback = function()
                    vim.cmd("FormatWrite")
                end,
            })
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            local trouble = require("trouble")
            trouble.setup()
            vim.keymap.set("n", "<leader>xx", function()
                trouble.toggle()
            end)
            vim.keymap.set("n", "<leader>xw", function()
                trouble.toggle("workspace_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xd", function()
                trouble.toggle("document_diagnostics")
            end)
            vim.keymap.set("n", "<leader>xq", function()
                trouble.toggle("quickfix")
            end)
            vim.keymap.set("n", "<leader>xl", function()
                trouble.toggle("loclist")
            end)
            vim.keymap.set("n", "gR", function()
                trouble.toggle("lsp_references")
            end)
        end,
    },
    {
        "echasnovski/mini.surround",
        opts = {},
    },
}
