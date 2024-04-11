return {
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      -- Do not confirm on enter, use tab instead
      opts.mapping["<CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end
      opts.mapping["<Tab>"] = cmp.mapping.confirm({ select = true })
    end,
  },
}
