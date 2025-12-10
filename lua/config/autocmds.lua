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

-- TypeScript: Auto-add missing imports and remove unused imports on save
--
-- How it works:
-- 1. Snacks.util.lsp.on() runs the callback when an LSP client attaches to a buffer
--    that supports code actions (the { method = "textDocument/codeAction" } filter)
-- 2. We set up a BufWritePre autocmd that runs before each save
-- 3. On save, we request specific code actions from the LSP and apply them synchronously
--
-- Why the complexity:
-- - Multiple LSP clients can attach to one buffer (vtsls, eslint, etc.), so we use
--   a buffer-local variable (vim.b[bufnr].ts_imports_on_save) to only set up once
-- - Some code actions are "lazy" - they return just metadata (action.data) instead
--   of the actual edit. These need a second "codeAction/resolve" request to get
--   the real edit. We must resolve immediately before the LSP's cache expires.
-- - We use synchronous requests (buf_request_sync) so edits apply before the file saves

Snacks.util.lsp.on({ method = "textDocument/codeAction" }, function(bufnr)
  -- Only set up autocmd once per buffer, even if multiple LSP clients attach
  if vim.b[bufnr].ts_imports_on_save then
    return
  end
  vim.b[bufnr].ts_imports_on_save = true

  local group = vim.api.nvim_create_augroup("ts_imports_on_save", { clear = false })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    buffer = bufnr,
    callback = function()
      --- Request a specific code action from the LSP and apply it synchronously
      --- @param kind string The code action kind (e.g., "source.addMissingImports.ts")
      local function apply_ts_action(kind)
        -- Get position encoding from first attached LSP client (needed for range params)
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        local encoding = clients[1] and clients[1].offset_encoding or "utf-16"

        -- Build the code action request parameters
        local params = vim.lsp.util.make_range_params(nil, encoding)
        params.context = {
          only = { kind }, -- filter to only this action type
          diagnostics = {},
        }

        -- Send synchronous request to all LSP clients (waits up to 1 second)
        local results = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)

        for client_id, res in pairs(results or {}) do
          for _, action in ipairs(res.result or {}) do
            -- Handle "lazy" actions that need resolving to get the actual edit
            if action.data and not action.edit then
              local resolved = vim.lsp.buf_request_sync(bufnr, "codeAction/resolve", action, 1000)
              if resolved and resolved[client_id] and resolved[client_id].result then
                action = resolved[client_id].result
              end
            end

            -- Apply the workspace edit (the actual code changes)
            if action.edit then
              local client = vim.lsp.get_client_by_id(client_id)
              local offset = client and client.offset_encoding or "utf-16"
              vim.lsp.util.apply_workspace_edit(action.edit, offset)
            end

            -- Some actions use commands instead of direct edits
            if action.command then
              vim.lsp.buf.execute_command(action.command)
            end
          end
        end
      end

      -- Apply both actions in order: first add missing, then remove unused
      apply_ts_action("source.addMissingImports.ts")
      apply_ts_action("source.removeUnused.ts")
    end,
  })
end)
