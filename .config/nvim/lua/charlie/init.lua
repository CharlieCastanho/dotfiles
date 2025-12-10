require("charlie.remap")
require("charlie.set")
require("charlie.lazy_init")

-- Function to trim trailing whitespace and empty lines
local function trim_trailing_spaces_and_lines()
  -- Remove trailing spaces
  vim.cmd([[ %s/\s\+$//e ]])
  -- Remove empty lines at the end of the file
  vim.cmd([[ %s/\n\+\%$//e ]])
end

-- Automatically trim on buffer write
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = trim_trailing_spaces_and_lines,
})
