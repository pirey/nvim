return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree dir=./ toggle reveal<cr>" },
      { "<leader>E", "<cmd>Neotree reveal_force_cwd<cr>" },
    },
    opts = {
      sources = {
        "filesystem",
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            -- auto close
            -- vimc.cmd("Neotree close")
            -- OR
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
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
        height = "50%",
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
