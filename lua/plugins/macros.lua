return {
  {
    "chrisgrieser/nvim-recorder",
    dependencies = "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      -- These must match the keys in the mapping config below, and are required
      -- so that keymaps are included in which-key given the plugin is lazy loaded.
      { "q", desc = " Start Recording" },
      { "Q", desc = " Play Recording" },
    },
    config = function()
      require("recorder").setup({
        mapping = {
          startStopRecording = "q",
          playMacro = "Q",
        },
      })
    end,
  },
}
