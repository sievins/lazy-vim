return {
  {
    "xiyaowong/nvim-transparent",
    event = "VeryLazy",
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
        "NvimTreeNormal", -- NvimTree
      },
    },
    config = function()
      local transparent = require("transparent")
      transparent.clear_prefix("Bufferline")
      transparent.clear_prefix("NeoTree")
      transparent.clear_prefix("lualine")
    end,
    keys = {
      { "<leader>t", "<cmd>TransparentToggle<CR>", desc = "Toggle Transparency" },
    },
  },
}
