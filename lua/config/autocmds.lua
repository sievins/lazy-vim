-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Rust
local rt = require("rust-tools")

rt.setup()

-- Snippets
vim.api.nvim_create_autocmd("TextChangedI", {
  callback = function()
    local blink_cmp = require("blink.cmp")
    if blink_cmp.is_visible() then
      blink_cmp.reload("snippets")
    end
  end,
})
