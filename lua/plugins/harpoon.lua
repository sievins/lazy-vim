return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- REQUIRED
      harpoon:setup({})
      -- REQUIRED

      -- Basic telescope configuration
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "Add file to harpoon" })

      vim.keymap.set("n", "<leader>he", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Toggle harpoon menu" })

      vim.keymap.set("n", "<leader>ht", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Add file to harpoon" })

      vim.keymap.set("n", "<M-h>", function()
        harpoon:list():select(1)
      end, { desc = "Select first harpoon file" })

      vim.keymap.set("n", "<M-t>", function()
        harpoon:list():select(2)
      end, { desc = "Select second harpoon file" })

      vim.keymap.set("n", "<M-s>", function()
        harpoon:list():select(3)
      end, { desc = "Select third harpoon file" })

      vim.keymap.set("n", "<M-n>", function()
        harpoon:list():select(4)
      end, { desc = "Select forth harpoon file" })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<M-[>", function()
        harpoon:list():prev()
      end, { desc = "Go to previous harpoon file" })

      vim.keymap.set("n", "<M-]>", function()
        harpoon:list():next()
      end, { desc = "Go to next harpoon file" })
    end,
  },
}
