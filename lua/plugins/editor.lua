return {
    -- Neotree
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            neotree = true,
        },
        config = function()
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            filesystem = {
                follow_current_file = {
                    enabled = true,
                },
                hijack_netrw_behavior = "open_current",
                use_libuv_file_watcher = true,
            },
        },
        keys = {
            { "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "Telescope",
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    prompt_prefix = "",
                    selection_caret = "",
                    sorting_strategy = "ascending",
                    path_display = {
                        "shorten",
                    },
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            width = 0.75,
                            height = 0.65,
                            preview_width = 0.6,
                        },
                    },
                    mappings = {
                        i = {
                            ["<C-k>"] = function(...)
                                actions.move_selection_previous(...)
                            end,
                            ["<C-j>"] = function(...)
                                actions.move_selection_next(...)
                            end,
                        },
                        n = {
                            ["q"] = function(...)
                                actions.close(...)
                            end,
                        },
                    },
                },
            }
        end,
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "" },
            { "<leader>of", "<cmd>Telescope oldfiles<cr>", desc = "" },
            { "<leader>lg", "<cmd>Telescope live_grep<cr>", desc = "" },
            { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "" },
            { "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "" },
            { "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "" },
        },
    },

    -- Lazygit
    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        keys = function()
            local lazygit = require("lazygit")
            return {
                {
                    "<leader>gg",
                    function()
                        lazygit.lazygit()
                    end,
                    desc = "Lazygit",
                },
            }
        end,
        config = function()
            require("telescope").load_extension("lazygit")
        end,
        opt = {},
    },

    -- Mini.nvim libraries
    {
        "echasnovski/mini.bufremove",
        opts = {},
        keys = function()
            local bufremove = require("mini.bufremove")
            return {
                {
                    "<leader>bd",
                    function()
                        bufremove.delete(0, false)
                    end,
                    desc = "Delete buffer",
                },
                {
                    "<leader>bD",
                    function()
                        bufremove.delete(0, true)
                    end,
                    desc = "Delete buffer (Force)",
                },
            }
        end,
    },

    {
        "echasnovski/mini.pairs",
        event = {
            "BufReadPost",
        },
        opts = {},
    },

    {
        "echasnovski/mini.indentscope",
        event = {
            "BufReadPost",
        },
        opts = {},
    },

    {
        "mrjones2014/smart-splits.nvim",
        lazy = false,
        opts = {},
    },

    {
        "numToStr/Comment.nvim",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        opts = {},
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        event = "VeryLazy",
        opts = {
            options = {
                theme = "catppuccin",
                globalstatus = true,
                disabled_filetypes = {
                    statusline = {
                        "dashboard",
                        "alpha",
                    },
                },
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_a = {
                    { "mode", icons_enabled = true },
                },
                lualine_b = {
                    "branch",
                    "diff",
                    "diagnostics",
                },
                lualine_c = {
                    { "filename", path = 1 },
                },
            },
        },
    },

    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
            { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        },
        opts = {
            options = {
                offsets = {
                    {
                        filetype = "neo-tree",
                    },
                },
            },
        },
    },

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            local logo = [[
                
            ]]

            dashboard.section.header.val = vim.split(logo, "\n")
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
                dashboard.button("q", " " .. " Quit", ":qa<CR>"),
            }
            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end
            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8
            return dashboard
        end,
        config = function(_, dashboard)
            local lazy = require("lazy")
            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "AlphaReady",
                    callback = function()
                        lazy.show()
                    end,
                })
            end

            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = lazy.stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        opt = {},
        config = function()
            local ufo = require("ufo")
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true

            vim.keymap.set("n", "zR", ufo.openAllFolds)
            vim.keymap.set("n", "zM", ufo.closeAllFolds)
            ufo.setup({
                provider_selector = function()
                    return {
                        "treesitter",
                        "indent",
                    }
                end,
            })
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
}
