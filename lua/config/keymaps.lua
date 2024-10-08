-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set keymap for normal windows only (e.g. not quickfix)
local normal_window_keymap = function(mode, lhs, rhs, opts)
  local merged_opts = vim.tbl_extend("force", { noremap = true, expr = true }, opts or {})

  vim.keymap.set(mode, lhs, function()
    local buftype = vim.fn.win_gettype()
    return buftype == "" and rhs or lhs
  end, merged_opts)
end

-- Add new line (like o/O) without moving the cursor, without entering insert mode and removing any characters
normal_window_keymap("n", "<CR>", "mao<esc>0<S-d>`a<cmd>delmarks a<cr>", { desc = "Add new line below" })
normal_window_keymap("n", "<S-CR>", "maO<esc>0<S-d>`a<cmd>delmarks a<cr>", { desc = "Add new line above" })

-- Keymap used by aerospace (window tiling manager)
-- Save with no action
-- vim.keymap.set("n", "<M-s>", "<cmd>noa w<cr>", { desc = "Save (no action)" })
-- vim.keymap.set("v", "<M-s>", "<cmd>noa w<cr>", { desc = "Save (no action)" })
vim.keymap.set("n", "<leader>fw", "<cmd>noa w<cr>", { desc = "Save (no action)" })
vim.keymap.set("v", "<leader>fw", "<cmd>noa w<cr>", { desc = "Save (no action)" })

-- Move lines (managed by <M-j/k>)
vim.keymap.set("v", "<M-down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-up>", ":m '<-2<CR>gv=gv")

-- Move to window using the <ctrl> arrow keys
vim.keymap.set("n", "<C-left>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-down>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-up>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-right>", "<C-w>l", { desc = "Go to right window", remap = true })
vim.keymap.set("t", "<C-left>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
vim.keymap.set("t", "<C-down>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
vim.keymap.set("t", "<C-up>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
vim.keymap.set("t", "<C-right>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

-- Resize window using <ctrl> homing keys
vim.keymap.set("n", "<C-pageup>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-pagedown>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-home>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-end>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Undo history
vim.keymap.set("n", "<M-u>", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- Paste/Delete and preserve original copy
vim.keymap.set("x", "<M-p>", [["_dP]], { desc = "Paste (preserve copy)" })
vim.keymap.set("n", "<M-d>", [["_dd]], { desc = "Delete (black hole register)" })
vim.keymap.set("x", "<M-d>", [["_d]], { desc = "Delete (black hole register)" })

-- Markdown preview
vim.keymap.set("n", "<leader>fm", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Markdown preview" })

-- Open URL
vim.keymap.set("n", "<M-o>", "<cmd>URLOpenUnderCursor<cr>", { desc = "Open URL" })

-- Copy filename / path
vim.keymap.set("n", "<leader>bcf", '<cmd>let @+ = expand("%:t")<cr>', { desc = "Copy filename" })
vim.keymap.set("n", "<leader>bcp", '<cmd>let @+ = expand("%")<cr>', { desc = "Copy path" })

-- Buffer
vim.keymap.set("n", "<S-left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

vim.keymap.set("n", "[b", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
vim.keymap.set("n", "]b", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })

vim.keymap.set("n", "<M-w>", "<cmd>bdelete<cr>", { desc = "Delete buffer and window" })

local split_window_right = function()
  local original_buffer = vim.fn.bufnr()
  vim.cmd.BufferLineCyclePrev()
  vim.cmd("vert sb " .. original_buffer)
end

local split_window_below = function()
  local original_buffer = vim.fn.bufnr()
  vim.cmd.BufferLineCyclePrev()
  vim.cmd("sb " .. original_buffer)
end

vim.keymap.set("n", "<leader>|", split_window_right, { desc = "Prev Window Right" })

vim.keymap.set("n", "<leader>-", split_window_below, { desc = "Prev Window Below" })

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
