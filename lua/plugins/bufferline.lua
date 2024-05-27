local background = "#011627"
local highlight = "#1d3b53"

return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "ordinal",
        indicator = {
          style = "none",
        },
        separator_style = "none",
      },
      highlights = {
        fill = {
          bg = background,
        },
        background = {
          bg = background,
        },
        buffer_selected = {
          bg = highlight,
        },
        buffer_visible = {
          bg = highlight,
        },
        close_button = {
          bg = background,
        },
        close_button_selected = {
          bg = highlight,
        },
        close_button_visible = {
          bg = highlight,
        },
        numbers = {
          bg = background,
        },
        numbers_selected = {
          bg = highlight,
        },
        numbers_visible = {
          bg = highlight,
        },
        diagnostic = {
          bg = background,
        },
        diagnostic_selected = {
          bg = highlight,
        },
        diagnostic_visible = {
          bg = highlight,
        },
        hint = {
          bg = background,
        },
        hint_selected = {
          bg = highlight,
        },
        hint_visible = {
          bg = highlight,
        },
        hint_diagnostic = {
          bg = background,
        },
        hint_diagnostic_selected = {
          bg = highlight,
        },
        hint_diagnostic_visible = {
          bg = highlight,
        },
        info = {
          bg = background,
        },
        info_selected = {
          bg = highlight,
        },
        info_visible = {
          bg = highlight,
        },
        info_diagnostic = {
          bg = background,
        },
        info_diagnostic_selected = {
          bg = highlight,
        },
        info_diagnostic_visible = {
          bg = highlight,
        },
        warning = {
          bg = background,
        },
        warning_selected = {
          bg = highlight,
        },
        warning_visible = {
          bg = highlight,
        },
        warning_diagnostic = {
          bg = background,
        },
        warning_diagnostic_selected = {
          bg = highlight,
        },
        warning_diagnostic_visible = {
          bg = highlight,
        },
        error = {
          bg = background,
        },
        error_selected = {
          bg = highlight,
        },
        error_visible = {
          bg = highlight,
        },
        error_diagnostic = {
          bg = background,
        },
        error_diagnostic_selected = {
          bg = highlight,
        },
        error_diagnostic_visible = {
          bg = highlight,
        },
        modified = {
          bg = background,
        },
        modified_selected = {
          bg = highlight,
        },
        modified_visible = {
          bg = highlight,
        },
        duplicate = {
          bg = background,
        },
        duplicate_selected = {
          bg = highlight,
        },
        duplicate_visible = {
          bg = highlight,
        },
        separator = {
          bg = background,
          -- Gets rid of tiny line next to separator
          fg = background,
        },
        separator_selected = {
          bg = highlight,
        },
        separator_visible = {
          bg = highlight,
        },
        pick = {
          bg = background,
        },
        pick_selected = {
          bg = highlight,
        },
        pick_visible = {
          bg = highlight,
        },
        -- +x buffers to the right/left
        trunc_marker = {
          bg = background,
        },
      },
    },
  },
}
