return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ignore_install = { "help" },
      ensure_installed = { "http", "json" },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>v",
          node_incremental = "<leader>v",
          node_decremental = "<c-h>", -- easier to reach than backspace key
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
