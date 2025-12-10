function OpenTree()
    local api = require('nvim-tree.api')
    api.tree.toggle({ focus = true })
    api.tree.collapse_all()
end

function ExpandToCurrentFile()
    local api = require('nvim-tree.api')
    api.tree.toggle({focus = false})
    api.tree.find_file({ open = true, focus = true })
end

return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- Trigger loading on these commands
        keys = {
            { "<C-h>", ":lua OpenTree()<CR>", desc = "Toggle NvimTree" },
            { "<C-f>", ":lua ExpandToCurrentFile()<CR>", desc = "Expand to Current File" },
        },
        config = function()
            local HEIGHT_RATIO = 0.7
            local WIDTH_RATIO = 0.4

            -- Disable netrw
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                view = {
                    float = {
                        enable = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w * WIDTH_RATIO
                            local window_h = screen_h * HEIGHT_RATIO
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                            return {
                                border = "rounded",
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int,
                            }
                        end,
                    },
                    width = function()
                        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                    end,
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                diagnostics = {
                    enable = true,
                    show_on_dirs = true,
                },
            })
        end,
    }
}
