-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move lines (managed by <M-j/k>)
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Undo history
vim.keymap.set("n", "<S-u>", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- Paste and preserve original copy
vim.keymap.set("x", "<S-p>", [["_dP]], { desc = "Paste (preserve copy)" })

-- Markdown preview

vim.keymap.set("n", "<M-m>", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown preview" })

-- Buffer
vim.keymap.set("n", "[b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
vim.keymap.set("n", "]b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })

vim.keymap.set("n", "<M-w>", "<cmd>bdelete<cr>", { desc = "Delete buffer and window" })

vim.keymap.set(
  "n",
  "<leader>1",
  "<cmd>lua require('bufferline').go_to_buffer(1, true)<cr>",
  { desc = "Go to buffer 1" }
)
vim.keymap.set(
  "n",
  "<leader>2",
  "<cmd>lua require('bufferline').go_to_buffer(2, true)<cr>",
  { desc = "which_key_ignore" }
)
vim.keymap.set(
  "n",
  "<leader>3",
  "<cmd>lua require('bufferline').go_to_buffer(3, true)<cr>",
  { desc = "which_key_ignore" }
)
vim.keymap.set(
  "n",
  "<leader>4",
  "<cmd>lua require('bufferline').go_to_buffer(4, true)<cr>",
  { desc = "which_key_ignore" }
)
vim.keymap.set(
  "n",
  "<leader>5",
  "<cmd>lua require('bufferline').go_to_buffer(5, true)<cr>",
  { desc = "which_key_ignore" }
)
vim.keymap.set(
  "n",
  "<leader>6",
  "<cmd>lua require('bufferline').go_to_buffer(6, true)<cr>",
  { desc = "which_key_ignore" }
)
vim.keymap.set(
  "n",
  "<leader>7",
  "<cmd>lua require('bufferline').go_to_buffer(7, true)<cr>",
  { desc = "which_key_ignore" }
)
vim.keymap.set(
  "n",
  "<leader>8",
  "<cmd>lua require('bufferline').go_to_buffer(8, true)<cr>",
  { desc = "which_key_ignore" }
)
vim.keymap.set(
  "n",
  "<leader>9",
  "<cmd>lua require('bufferline').go_to_buffer(9, true)<cr>",
  { desc = "which_key_ignore" }
)
