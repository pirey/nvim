local function openRoot()
  require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
end

local function openCwd()
  require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        openCwd,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        openRoot,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", openCwd, desc = "Explorer NeoTree (root dir)" },
      { "<leader>E", openRoot, desc = "Explorer NeoTree (cwd)" },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      window = {
        position = "right",
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
        }
      },
    },
  },
}
