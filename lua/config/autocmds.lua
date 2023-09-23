-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Rust
local rt = require("rust-tools")

rt.setup()

-- Snippets
require("luasnip").filetype_extend("typescript", { "javascript" })
require("luasnip").filetype_extend("typescriptreact", { "javascript" })
