return {
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        command_palette = false, -- position the cmdline and popupmenu together
        cmdline_output_to_split = true, -- send the output of a command you executed in the cmdline to a split
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
