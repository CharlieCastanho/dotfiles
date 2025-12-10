return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            dap.adapters.coreclr = {
                type = 'executable',
                command = '/usr/local/bin/netcoredbg/netcoredbg',
                args = { '--interpreter=vscode' },
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                    end,
                },
            }

            -- Key mappings
            vim.keymap.set('n', '<F5>', function() require 'dap'.continue() end, { silent = true })
            vim.keymap.set('n', '<Leader>so', function() require 'dap'.step_over() end, { silent = true })
            vim.keymap.set('n', '<Leader>si', function() require 'dap'.step_into() end, { silent = true })
            vim.keymap.set('n', '<F12>', function() require 'dap'.step_out() end, { silent = true })
            vim.keymap.set('n', '<Leader>b', function() require 'dap'.toggle_breakpoint() end, { silent = true })
            vim.keymap.set('n', '<Leader>B',
                function() require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { silent = true })
            vim.keymap.set('n', '<Leader>lp',
                function() require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end,
                { silent = true })
            vim.keymap.set('n', '<Leader>dr', function() require 'dap'.repl.open() end, { silent = true })
            vim.keymap.set('n', '<Leader>dl', function() require 'dap'.run_last() end, { silent = true })
        end,
    },
}
