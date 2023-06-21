return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        branch = "v2.x",
        lazy = false,
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                },
                hijack_netrw_behavior = "open_default",
            },
            window = {
                mappings = {
                    ["a"] = {
                        "add",
                        config = {
                            show_path = "relative",
                        },
                    },
                },
            },
        },
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({ toggle = true })
                end,
                desc = "Explorer NeoTree (root dir)",
            },
            { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "Search files",
            },

            {
                "<leader>fg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Live grep",
            },

            {
                "<leader>fc",
                function()
                    require("telescope.builtin").git_commits()
                end,
                desc = "Git Commits",
            },
        },
        opts = {
            defaults = {
                prompt_prefix = "",
                selection_caret = "",
                mappings = {
                    i = {
                        ["<C-k>"] = function(...)
                            require("telescope.actions").move_selection_previous(...)
                        end,
                        ["<C-j>"] = function(...)
                            require("telescope.actions").move_selection_next(...)
                        end,
                    },
                },
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                spelling = true,
            },
        },
    },

    {
        "lewis6991/gitsigns.nvim",
        event = {
            "BufReadPre",
            "BufNewFile",
        },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        },
    },

    {
        "RRethy/vim-illuminate",
        event = {
            "BufReadPost",
            "BufNewFile",
        },
        opts = {
            delay = 200,
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
        keys = {
            { "]]", desc = "Next Reference" },
            { "[[", desc = "Prev Reference" },
        },
    },

    {
        "echasnovski/mini.bufremove",
        -- stylua: ignore
        keys = {
            { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
            { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
        },
    },

    {
        "folke/trouble.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
            { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
        },
        opts = {},
    },

    {
        "akinsho/toggleterm.nvim",
        opts = {
            open_mapping = [[<C-\>]],
            winbar = {
                enabled = true,
            },
        },
    },

    {
        "christoomey/vim-tmux-navigator",
        config = false,
    },

    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>gg",
                function()
                    require("lazygit").lazygit()
                end,
                desc = "Lazygit",
            },
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },
}
