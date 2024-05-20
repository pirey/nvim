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
    },
  },
}
