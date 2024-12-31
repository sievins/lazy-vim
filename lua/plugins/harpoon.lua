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

      vim.keymap.set("n", "<leader>hA", function()
        harpoon:list():clear()
        harpoon:list():add()
      end, { desc = "Clear list and add file to harpoon" })

      vim.keymap.set("n", "<leader>he", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Toggle harpoon menu" })

      vim.keymap.set("n", "<leader>ht", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Toggle harpoon telescope" })

      vim.keymap.set("n", "<leader>hc", function()
        harpoon:list():clear()
      end, { desc = "Clear all files in the harpoon list" })

      -- Most of these shift keys are reserved and I've found that remembering
      -- which file is under which key hard to remember. So I'll just use
      -- <S-up> and <S-down> to switch between files.
      --
      -- vim.keymap.set("n", "<S-h>", function()
      --   harpoon:list():select(1)
      -- end, { desc = "Select first harpoon file" })
      --
      -- vim.keymap.set("n", "<S-t>", function()
      --   harpoon:list():select(2)
      -- end, { desc = "Select second harpoon file" })
      --
      -- vim.keymap.set("n", "<S-s>", function()
      --   harpoon:list():select(3)
      -- end, { desc = "Select third harpoon file" })
      --
      -- vim.keymap.set("n", "<S-n>", function()
      --   harpoon:list():select(4)
      -- end, { desc = "Select forth harpoon file" })

      -- Update lualine config below if adding more keymaps

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<S-down>", function()
        harpoon:list():prev()
      end, { desc = "Go to previous harpoon file" })

      vim.keymap.set("n", "<S-up>", function()
        harpoon:list():next()
      end, { desc = "Go to next harpoon file" })
    end,
  },
  -- harpoonline has been archived - possible alternative: https://github.com/letieu/harpoon-lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "abeldekat/harpoonline", version = "*" },
    config = function(_, opts)
      local Harpoonline = require("harpoonline")
      Harpoonline.setup({
        ---@param data HarpoonlineData
        ---@return string HarpoonLine *file1 file2 ...
        custom_formatter = function(data)
          local index = 0
          return #data.items == 0 and ""
            or table.concat(
              vim.tbl_map(function(item)
                index = index + 1
                local filename = string.find(item.value, "/") == nil and item.value
                  or item.value:match(".*" .. "/" .. "(.*)")
                return data.active_idx == index and "*" .. filename or filename
              end, data.items),
              " "
            )
        end,

        on_update = function()
          require("lualine").refresh()
        end,
      })

      ---@param inputstr string
      ---@param del string
      ---@return table<string>
      local function split(inputstr, del)
        if del == nil then
          del = "%s"
        end
        local t = {}
        for str in string.gmatch(inputstr, "([^" .. del .. "]+)") do
          table.insert(t, str)
        end
        return t
      end

      ---@return boolean
      local function isHarpoonActive()
        return Harpoonline.format() ~= ""
      end

      ---@param index number
      ---@return string | nil
      local function getFile(index)
        local files = split(Harpoonline.format(), " ")
        local file = files[index]
        -- Remove leading '*' character if present
        return file and string.sub(file, 1, 1) == "*" and string.sub(file, 2) or file
      end

      ---@param index number
      ---@return boolean
      local isFileHarpooned = function(index)
        local files = split(Harpoonline.format(), " ")
        return files[index] ~= nil
      end

      ---@param index number
      ---@return boolean
      local function isFileCurrentBuffer(index)
        local files = split(Harpoonline.format(), " ")
        local file = files[index]
        return file and string.sub(file, 1, 1) == "*"
      end

      ---@param index number
      ---@param isActiveLine boolean
      local function createLualine(index, isActiveLine)
        if isActiveLine then
          return {
            function()
              return isHarpoonActive() and isFileHarpooned(index) and isFileCurrentBuffer(index) and getFile(index)
                or ""
            end,
            "filename",
            color = { fg = "#a1cd5e" },
          }
        else
          return {
            function()
              return isHarpoonActive() and isFileHarpooned(index) and not isFileCurrentBuffer(index) and getFile(index)
                or ""
            end,
            "filename",
          }
        end
      end

      local lualines = {
        {
          function()
            return isHarpoonActive() and "󰛢 [" or ""
          end,
          "filename",
          color = { fg = "#a1cd5e" },
        },
        createLualine(1, true),
        createLualine(1, false),
        createLualine(2, true),
        createLualine(2, false),
        createLualine(3, true),
        createLualine(3, false),
        createLualine(4, true),
        createLualine(4, false),
        createLualine(5, true),
        createLualine(5, false),
        createLualine(6, true),
        createLualine(6, false),
        {
          function()
            return isHarpoonActive() and "]" or ""
          end,
          "filename",
          color = { fg = "#a1cd5e" },
        },
      }

      local function reverseInsert(tbl, tblToInsert)
        for i = #tblToInsert, 1, -1 do
          table.insert(tbl, 1, tblToInsert[i])
        end
      end

      reverseInsert(opts.sections.lualine_c, lualines)

      require("lualine").setup(opts)
    end,
  },
}
