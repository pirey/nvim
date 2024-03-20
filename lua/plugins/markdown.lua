return {
  {
    "lukas-reineke/headlines.nvim",
    enabled = false, -- disable because of slow performance
    opts = {
      markdown = {
        fat_headline_lower_string = "▀",
      },
      norg = {
        fat_headline_lower_string = "▀",
      },
      org = {
        fat_headline_lower_string = "▀",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {},
      },
    },
  },
}
