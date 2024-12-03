return {
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {
      document_color = {
        enabled = true, -- can be toggled by commands
        kind = "background", -- "inline" | "foreground" | "background"
        inline_symbol = "", -- only used in inline mode
        debounce = 200, -- in milliseconds, only applied in insert mode
      },
    },
  },
  {
    "razak17/tailwind-fold.nvim",
    enabled = false, -- NOTE: could not use sort feature of tailwind-tools.nvim when it is enabled
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
  },
}
