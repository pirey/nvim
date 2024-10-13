return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        command_palette = false, -- position the cmdline and popupmenu together
      },
      cmdline = {
        view = "cmdline",
      },
      messages = {
        view_search = false,
      },
      views = {
        notify = {
          replace = true,
          merge = false,
        },
      },
      -- REMOVE THIS once this issue is fixed: https://github.com/yioneko/vtsls/issues/159
      routes = {
        {
          filter = {
            event = "notify",
            find = "Request textDocument/documentHighlight failed",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
