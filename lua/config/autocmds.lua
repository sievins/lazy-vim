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

-- Add imports before save and save again because imports updated asyncronously

-- local util = require("lazyvim.util")
--
-- util.lsp.on_attach(function(client, bufnr)
--   if client.server_capabilities.codeActionProvider then
--     vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--       group = vim.api.nvim_create_augroup("ts_imports_code_action_on_save", { clear = true }),
--       pattern = { "*.tsx,*.ts" },
--       callback = function()
--         LazyVim.lsp.action["source.addMissingImports.ts"]()
--         -- LazyVim.lsp.action["source.removeUnused.ts"]() -- prune unused imports - doesn't work: removes other imports and formats wrongly
--
--         vim.api.nvim_create_autocmd({ "TextChanged" }, {
--           group = vim.api.nvim_create_augroup("ts_imports_code_action_on_save_completed", {}),
--           callback = function()
--             vim.cmd.write()
--           end,
--           once = true,
--         })
--       end,
--     })
--   end
-- end)

-- Add imports on save syncronously

Snacks.util.lsp.on({ method = "textDocument/codeAction" }, function(bufnr)
  -- single group (won't be re‐cleared on every attach)
  local group = vim.api.nvim_create_augroup("ts_imports_on_save", { clear = false })

  -- helper: sync‐request + apply a single code-action kind
  local function apply_ts_action(kind)
    local params = vim.lsp.util.make_range_params()
    params.context = {
      only = { kind },
      diagnostics = {}, -- imports actions don't need diagnostics
    }
    -- sync request (blocks up to 1s)
    local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
    for _, res in pairs(results or {}) do
      for _, action in ipairs(res.result or {}) do
        if action.edit then
          local client = vim.lsp.get_client_by_id(res.client_id)
          local offset_encoding = client and client.offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(action.edit, offset_encoding)
        elseif action.command then
          vim.lsp.buf.execute_command(action.command)
        end
      end
    end
  end

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = bufnr,
    callback = function()
      -- prune unused imports - doesn't work: removes other imports and formats wrongly
      -- apply_ts_action("source.removeUnused.ts")
      -- add any missing imports
      apply_ts_action("source.addMissingImports.ts")
    end,
  })
end)
