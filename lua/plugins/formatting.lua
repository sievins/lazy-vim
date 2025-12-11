-- Formatting configuration
-- Use only prettier for TS/JS (disable slow LSP formatters)
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Use prettierd (daemon) for faster formatting, fall back to prettier
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
  -- Disable LSP formatting for TS/JS (eslint and vtsls are slow)
  -- Also disable inlay hints
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          settings = {
            typescript = {
              format = { enable = false },
            },
            javascript = {
              format = { enable = false },
            },
          },
        },
        eslint = {
          settings = {
            format = false,
          },
        },
      },
      inlay_hints = {
        enabled = false,
      },
    },
  },
}
