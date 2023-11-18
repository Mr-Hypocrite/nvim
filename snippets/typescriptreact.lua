local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    s(
        {
            trig = "rcomp",
            dscr = "Insert react FC component",
        },
        fmta(
            [[
                import { FC } from "react"

                export type $1Props = {}

                export const $1: FC<$1Props> = () => {

                    return null

                }
            ]],
            {
                i(1),
                rep(1),
                rep(1),
            },
            {
                delimiters = "$1",
            }
        )
    ),
}
