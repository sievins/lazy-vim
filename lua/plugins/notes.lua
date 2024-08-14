return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre /Users/samievins/Library/CloudStorage/OneDrive-Adarga/Notes/Work/**.md",
      "BufNewFile /Users/samievins/Library/CloudStorage/OneDrive-Adarga/Notes/Work/**.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      -- Recommended.
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "/Users/samievins/Library/CloudStorage/OneDrive-Adarga/Notes/Work",
        },
      },
      templates = {
        folder = "Templates",
      },
      -- TODO: Change obsidian's hightlight groups to match colorscheme
    },
  },
}
