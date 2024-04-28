local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- <leader><space> finds files in cwd, while <leader>ff finds files in the root directory.
      { "<leader><space>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    },
    opts = {
      defaults = {
        mappings = {
          -- Open file in split window
          i = {
            ["<M-s>"] = "file_vsplit",
            ["<M-S-s>"] = "file_split",
          },
          n = {
            ["s"] = "file_vsplit",
            ["<S-s>"] = "file_split",
          },
        },
      },
    },
  },
}
