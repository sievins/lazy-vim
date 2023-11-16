return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/OneDrive - Adarga/neorg/notes",
                specs = "~/OneDrive - Adarga/neorg/specs",
                elders = "~/OneDrive - Adarga/neorg/elders",
              },
            },
          },
          ["core.completion"] = { -- Get completions in Neorg files
            config = {
              engine = "nvim-cmp",
            },
          },
        },
      })
    end,
  },
}
