return {
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },

    {
        'nvim-telescope/telescope.nvim',

        dependencies = { 'nvim-lua/plenary.nvim' },

        config = function()
            require('telescope').setup({})

            local builtin = require('telescope.builtin')
            local sorters = require('telescope.sorters')
            vim.keymap.set('n', '<leader>fp', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git tracked files' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find open buffers' })

            vim.keymap.set('n', '<leader>fg', function()
                builtin.grep_string()
            end, { noremap = true, silent = true })

            vim.keymap.set('n', '<leader>ff', function()
                local opts = {
                    case_mode = "match",
                    sorter = sorters.get_substr_matcher({}),
                }
                builtin.current_buffer_fuzzy_find(opts)
            end, { noremap = true, silent = true, desc = 'Custom fuzzy search in current buffer' })

            vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { noremap = true, silent = true })

            local harpoon = require("harpoon")

            harpoon.setup()

            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for idx, item in ipairs(harpoon_files.items) do
                    local numbered_item = string.format("[%d] %s", idx, item.value)
                    table.insert(file_paths, numbered_item)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()

            end

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<leader>r", function() harpoon:list():remove() end)
            vim.keymap.set("n", "<leader>hd", function() harpoon:list():clear() end)
            vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

        end
    }
}
