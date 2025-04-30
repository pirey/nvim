return {
  "folke/snacks.nvim",
  opts = {
    dashboard = { enabled = false },
    animate = { enabled = false },
    scroll = { enabled = false },
    -- indent = { enabled = false },
    input = {
      win = {
        -- taken from the commented line from input docs.
        relative = "cursor",
        row = -3,
        col = 0,
      },
    },
    picker = {
      win = {
        input = {
          keys = {
            ["<esc>"] = { "cancel", mode = { "n", "i" } },
            ["<c-c>"] = { "cancel", mode = { "n" } },
          },
        },
      },
      formatters = {
        file = {
          -- filename_first = true,
        },
      },
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            hidden = { "input" },
            auto_hide = { "input" },
          },
        },
      },
    },
  },
  keys = {
    -- git
    { "<leader>gs", false },
    {
      "<leader>b/",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
  },
}
