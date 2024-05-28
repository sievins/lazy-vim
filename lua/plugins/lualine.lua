local custom_nightfly = require("lualine.themes.nightfly")

-- Better nightfly colors for transparent background
custom_nightfly.normal.a.bg = "#2c3043"
custom_nightfly.normal.a.fg = "#82aaff"
custom_nightfly.normal.b.bg = "#2c3043"
custom_nightfly.normal.b.fg = "#82aaff"
custom_nightfly.insert.a.bg = "#2c3043"
custom_nightfly.insert.a.fg = "#21c7a8"
custom_nightfly.insert.b.bg = "#2c3043"
custom_nightfly.insert.b.fg = "#21c7a8"
custom_nightfly.visual.a.bg = "#2c3043"
custom_nightfly.visual.a.fg = "#ae81ff"
custom_nightfly.visual.b.bg = "#2c3043"
custom_nightfly.visual.b.fg = "#ae81ff"
custom_nightfly.replace.a.bg = "#2c3043"
custom_nightfly.replace.a.fg = "#ff5874"
custom_nightfly.replace.b.bg = "#2c3043"
custom_nightfly.replace.b.fg = "#ff5874"
custom_nightfly.command = {
  a = { bg = "#2c3043", fg = "#ecc48d" },
  b = { bg = "#2c3043", fg = "#ecc48d" },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        -- theme = "nightfly",
        theme = custom_nightfly,

        -- For transparent background
        section_separators = "",
        component_separators = "",
      },
    },
  },
}
