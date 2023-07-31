return {
  {
    "folke/noice.nvim",
    opts = {
      messages = {
        view_search = false,
      },
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = { 1, 1 },
          },
          filter_options = {},
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    },
  },
}
