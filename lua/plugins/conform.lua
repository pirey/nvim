return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      blade = { "blade-formatter" },
    },
    formatters = {
      ["blade-formatter"] = {
        prepend_args = { "--sort-classes" },
      },
    },
  },
}
