return {
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                },
                format_on_save = {
                    timeout_ms = 1500,
                    lsp_fallback = true,
                },
            })
        end,
    },
}
