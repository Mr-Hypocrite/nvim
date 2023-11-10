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
                },
            }
        end,
    },

    -- Completetion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
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
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
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
            lsp_zero.setup_servers({ "rust_analyzer", "gopls" })

            lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())
            lspconfig.tsserver.setup({
                single_file_support = false,
                commands = {
                    TypescriptOrganizeImports = {
                        function()
                            local param = {
                                command = "_typescript.organizeImports",
                                arguments = {
                                    vim.api.nvim_buf_get_name(0),
                                },
                                title = "Organize ts imports",
                            }
                            vim.lsp.buf.execute_command(param)
                        end,
                    },
                },
            })

            vim.keymap.set("n", "<leader>oi", "<cmd>TypescriptOrganizeImports<cr>", { silent = true, noremap = true })
            vim.keymap.set(
                "n",
                "<leader>ami",
                "<cmd>TypescriptAddMissingImports<CR>",
                { silent = true, noremap = true }
            )
            vim.keymap.set("n", "<leader>fa", "<cmd>TypescriptFixAll<CR>", { silent = true, noremap = true })
            vim.keymap.set("n", "<leader>ru", "<cmd>TypescriptRemoveUnused<CR>", { silent = true, noremap = true })
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
                        require("formatter.filetypes.typescript").prettiereslint,
                    },
                    typescriptreact = {
                        require("formatter.filetypes.typescript").prettiereslint,
                    },
                },
            })
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                group = vim.api.nvim_create_augroup("format_on_save", { clear = true }),
                callback = function()
                    vim.cmd("Format")
                end,
            })
        end,
    },
}
