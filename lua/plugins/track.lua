return {
  "dharmx/track.nvim",
  config = function()
    local set = vim.keymap.set -- tweak to suit your own
    -- set("n", "<leader>ta", "<cmd>Track<cr>", { silent = true })
    -- set("n", "<leader>te", "<cmd>Track bundles<cr>", { silent = true })
    -- set("n", "<leader>ta", "<cmd>Mark<cr>", { silent = true })
    -- set("n", "<leader>td", "<cmd>Unmark<cr>", { silent = true })

    -- alternatively require("track").setup()
    require("track").setup({ -- non-nerdfonts icons
      -- pickers = {
      --   bundles = {
      --     prompt_prefix = " > ",
      --     selection_caret = " > ",
      --     icons = {
      --       separator = " ",
      --       main = "*",
      --       alternate = "/",
      --       inactive = "#",
      --       mark = "=",
      --       history = "<",
      --     },
      --   },
      --   views = {
      --     selection_caret = " > ",
      --     prompt_prefix = " > ",
      --     icons = {
      --       separator = " ",
      --       terminal = "#",
      --       manual = "^",
      --       missing = "?",
      --       accessible = "*",
      --       inaccessible = "x",
      --       focused = "@",
      --       listed = "S",
      --       unlisted = "$",
      --       file = ".",
      --       directory = "~",
      --     },
      --   },
      -- },
    })
  end,
  keys = {
    { "<leader>tt", "<cmd>Track<cr>", desc = "Open tracked files" },
    { "<leader>ta", "<cmd>Mark<cr>", desc = "Mark file as tracked" },
    { "<leader>td", "<cmd>Unmark<cr>", desc = "Untrack file" },
    { "<leader>tb", "<cmd>Track bundles<cr>", desc = "Track bundles" },
  },
  cmd = {
    "Mark",
    "MarkOpened",
    "StashBundle",
    "RestoreBundle",
    "AlternateBundle",
    "Unmark",
    "Track",
  },
}
