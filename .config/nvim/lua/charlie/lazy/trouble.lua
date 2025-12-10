return {
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        lazy = false,
    },
    vim.keymap.set("n", "<leader>t", ":Trouble diagnostics toggle focus=false filter.buf=0<CR><C-w>j", { noremap = true, silent = true })

}
