return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle reveal<cr>" },
    },
    opts = {
      sources = {
        "filesystem",
      },
      filesystem = {
        follow_current_file = {
          enabled = false,
        },
        filtered_items = {
          hide_hidden = false,
          hide_gitignored = false,
          hide_dotfiles = false,
        },
      },
      window = {
        position = "bottom",
        mappings = {
          ["z"] = "noop",
          ["/"] = "noop",
          ["s"] = "noop",
          ["<esc>"] = "close_window",
          ["<c-v>"] = "open_vsplit",
          ["f"] = "fuzzy_finder",
          ["zM"] = "close_all_nodes",
          ["l"] = "open",
          ["h"] = "close_node",
          ["P"] = { "toggle_preview", config = { use_float = false } },
        },
      },
    },
  },
}
