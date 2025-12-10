return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        lazy = false,

        config = function()
            local ls = require("luasnip")
            vim.keymap.set({ "i", "s" }, "<Tab>", function()
                if ls.jumpable(1) then
                    ls.jump(1)
                else
                    return "<Tab>"
                end
            end, { silent = true, expr = true })

            vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                else
                    return "<S-Tab>"
                end
            end, { silent = true, expr = true })
        end,
    }
}
