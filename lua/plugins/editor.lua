return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        branch = "v2.x",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
            sources = {
                "filesystem",
                "buffers",
                "git_status",
            },
            source_selector = {
                winbar = true,
                content_layout = "center",
                sources = {
                    { source = "filesystem", display_name = require("config.icons").FolderClosed .. " File" },
                    { source = "buffers", display_name = require("config.icons").DefaultFile .. " Bufs" },
                    { source = "git_status", display_name = require("config.icons").Git .. " Git" },
                    { source = "diagnostics", display_name = require("config.icons").Diagnostic .. " Diagnostic" },
                },
            },
            default_component_configs = {
                indent = {
                    padding = 0,
                },
                icon = {
                    folder_closed = require("config.icons").FolderClosed,
                    folder_open = require("config.icons").FolderOpen,
                    folder_empty = require("config.icons").FolderEmpty,
                    folder_empty_open = require("config.icons").FolderEmpty,
                    default = require("config.icons").DefaultFile,
                },
            },
            filesystem = {
                follow_current_file = true,
                hijack_netrw_behavior = "open_current",
                use_libuv_file_watcher = true,
            },
        },
        keys = {
            {
                "<leader>fe",
                function()
                    require("neo-tree.command").execute({
                        toggle = true,
                    })
                end,
            },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "Telescope",
        keys = {
            {
                "<leader>ff",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "[ F ]ind files",
            },
            {
                "<leader>fF",
                function()
                    require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
                end,
                desc = "[ F ]ind [ F ]iles",
            },

            {
                "<leader>lg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "[ L ]ive [g]rep",
            },

            {
                "<leader>of",
                function()
                    require("telescope.builtin").oldfiles()
                end,
                desc = "[ O ]ld [ F ]iles",
            },

            {
                "<leader>ds",
                function()
                    require("telescope.builtin").lsp_document_symbols()
                end,
                desc = "[ D ]ocument [ S ]ymbols",
            },

            {
                "<leader>wss",
                function()
                    require("telescope.builtin").lsp_dynamic_workspace_symbols()
                end,
                desc = "[ W ]orkspace [ S ]ymbol[ s ]",
                remap = true,
            },

            {
                "<leader>lr",
                function()
                    require("telescope.builtin").lsp_references()
                end,
                desc = "[L]ist [R]erefrences",
            },
            {
                "<leader>ld",
                function()
                    require("telescope.builtin").diagnostics()
                end,
                desc = "[ L ]ist [ D ]iagnostics",
            },
            {
                "<leader>li",
                function()
                    require("telescope.builtin").lsp_implementations()
                end,
                desc = "[ L ]ist [ I ]mplementation",
            },
            {
                "<leader>ldi",
                function()
                    require("telescope.builtin").lsp_definitions()
                end,
                desc = "[ L ]ist [ D ]ef[ i ]nitions",
            },
        },
        opts = {
            defaults = {
                path_display = { "truncate" },
                sorting_strategy = "ascending",
                layout_config = {
                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                prompt_prefix = require("config.icons").Selected,
                selection_caret = require("config.icons").Selected,
                mappings = {
                    i = {
                        ["<C-k>"] = function(...)
                            require("telescope.actions").move_selection_previous(...)
                        end,
                        ["<C-j>"] = function(...)
                            require("telescope.actions").move_selection_next(...)
                        end,
                    },
                    n = {
                        q = function(...)
                            require("telescope.actions").close(...)
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

    -- We need to make sure we put this before the toggleterm
    -- cause vim-tmux-navigator also has a <c-\> keybinding
    {
        "christoomey/vim-tmux-navigator",
        config = false,
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

    {
        "mrjones2014/smart-splits.nvim",
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        opts = {},
    },
}
