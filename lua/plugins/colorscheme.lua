return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1003,
        opts = {
            neotree = true,
            custom_highlights = function(colors)
                local u = require("catppuccin.utils.colors")
                return {
                    CursorLine = {
                    bg = u.lighten(colors.mantle, 0.90, colors.surface0),
                },
                    Visual = {
                    fg = colors.text,
                    bg = u.lighten(colors.mantle, 0.10, colors.overlay1),
                },
            }
            end,
                transparent_background = true
        },
        config = function(_,opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin-mocha")
        end,
    },
}
