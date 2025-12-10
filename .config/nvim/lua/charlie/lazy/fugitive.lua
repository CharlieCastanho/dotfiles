return
{
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gt", vim.cmd.Git)
        end
    }
}
