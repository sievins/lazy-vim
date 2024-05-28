return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        -- Do not display message when toggling hidden files with "H" in Neo-tree
        {
          filter = {
            find = "Toggling hidden files",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
