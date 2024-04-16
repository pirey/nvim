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
      messages = {},
      views = {
        notify = {
          replace = true,
          merge = false,
        },
      },
    },
  },
}
