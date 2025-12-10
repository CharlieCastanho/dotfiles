vim.g.mapleader = " "

vim.keymap.set("n", "<leader>bd", ":bd<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- paste-ovewrite w/ changing register value
vim.keymap.set("x", "<leader>p", "\"_dP")

-- keep the cursor in the same place when jumpint page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

-- delete without copying
vim.keymap.set("n", "<leader>d", "\"_dP")
vim.keymap.set("v", "<leader>d", "\"_dP")

-- split
vim.keymap.set("n", "<leader>sv", ":vsplit<CR><C-w>l")
vim.keymap.set("n", "<leader>sh", ":split<CR><C-w>j")

-- Resize splits easily
vim.keymap.set('n', '<leader>+', ':resize +5<CR>')
vim.keymap.set('n', '<leader>-', ':resize -5<CR>')
vim.keymap.set('n', '<leader>>', ':vertical resize +5<CR>')
vim.keymap.set('n', '<leader><', ':vertical resize -5<CR>')

local maximized = false
local original_tab = nil

vim.keymap.set("n", "<leader>m", function()
    if not maximized then
        original_tab = vim.api.nvim_get_current_tabpage()
        vim.cmd("tab split")
        maximized = true
    else
        vim.cmd("tabclose")
        vim.cmd("tabnext" .. original_tab)
        maximized = false
    end
end, { desc = "Toggle maximize window" })


-- open terminal
vim.keymap.set("n", "<C-t>", ":belowright split | terminal<CR>:resize 10<CR>i")

-- Close all buffers
vim.keymap.set("n", "<leader>q", ":bufdo bd!<CR>")
vim.keymap.set("n", "<leader>wq", ":wa | bufdo bd<CR>")

-- Navigate buffers
vim.keymap.set('n', '<leader><Tab>', ':b#<CR>', { noremap = true, silent = true })

-- searching
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
