return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ignore_install = { "help" },
    ensure_installed = { "ocaml" },
    highlight = {
      disable = { "markdown", "json" },
    },
  },
}
