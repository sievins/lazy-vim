local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- <leader><space> finds files in cwd, while <leader>ff finds files in the root directory.
      { "<leader><space>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    },
  },
}
