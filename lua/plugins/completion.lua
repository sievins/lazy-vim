return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      lazy = true,
      build = (not LazyVim.is_win())
          and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
            local extends = {
              typescript = { "javascript" },
              typescriptreact = { "javascript" },
            }
            for ft, snips in pairs(extends) do
              require("luasnip").filetype_extend(ft, snips)
            end
          end,
        },
      },
      opts = {
        history = true,
        delete_check_events = "TextChanged",
      },
    },
    opts = {
      keymap = { preset = "super-tab" },
    },
  },
}
