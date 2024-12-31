return {
  "folke/snacks.nvim",
  opts = {
    dashboard = { enabled = false },
    animate = { enabled = false },
    scroll = { enabled = false },
    indent = { enabled = false },
    input = {
      win = {
        -- taken from the commented line from input docs.
        relative = "cursor",
        row = -3,
        col = 0,
      },
    },
  },
}
