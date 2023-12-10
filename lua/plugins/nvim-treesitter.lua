return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("orgmode").setup_ts_grammar()
    local opts = {
      ignore_install = { "help" },
      ensure_installed = { "org" },
      highlight = {
        enable = true,
        -- disable = { "markdown", "json" },
        additional_vim_regex_highlighting = { "org" },
      },
    }
    require("nvim-treesitter.configs").setup(opts)
  end,
}
