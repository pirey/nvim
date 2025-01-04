return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- disable markdown lint
        markdown = {},
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        enabled = false,
      },
      checkbox = {
        enabled = false,
      },
    },
  },
}
