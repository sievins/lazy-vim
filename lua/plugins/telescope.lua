return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- <leader><space> finds files in cwd, while <leader>ff finds files in the root directory.
      { "<leader><space>", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
    },
    opts = {
      defaults = {
        mappings = {
          -- Open file in split window
          i = {
            ["<M-S-\\>"] = "file_vsplit",
            ["<M-->"] = "file_split",
          },
          n = {
            ["<M-S-\\>"] = "file_vsplit",
            ["<M-->"] = "file_split",
            ["s"] = "file_vsplit",
            ["<S-s>"] = "file_split",
          },
        },
      },
    },
  },
}
