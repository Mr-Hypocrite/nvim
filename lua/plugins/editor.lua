return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependecies = {
            "nvim-lua/plenary.nvim"
        },
        keys = {
            {
                "<leader>sf",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "Search files"
            },

            {
                "<leader>sg",
                function ()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Live grep"
            }
        },
        opts = {
            defaults = {
                prompt_prefix = "",
                selection_caret = "",
                mappings = {
                    i = {
                        ["<C-k>"] = function(...) require("telescope.actions").move_selection_previous(...) end,
                        ["<C-j>"] = function(...) require("telescope.actions").move_selection_next(...) end,
                    }
                }
            }
        }
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                spelling = true
            }
        }
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
            }
        }
    }
}
