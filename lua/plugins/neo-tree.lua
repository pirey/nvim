return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      sources = {
        "filesystem",
      },
      filesystem = {
        filtered_items = {
          hide_hidden = false,
          hide_gitignored = false,
          hide_dotfiles = false,
        },
      },
      window = {
        position = "right",
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
    },
  },
}
