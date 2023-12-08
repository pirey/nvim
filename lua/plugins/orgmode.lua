return {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", lazy = true },
  },
  event = "VeryLazy",
  config = function()
    -- Load treesitter grammar for org
    require("orgmode").setup_ts_grammar()

    -- Setup treesitter
    local tsconfig = {
      modules = {
        {
          enable = true,
          additional_vim_regex_highlighting = { "org" },
        },
      },
      sync_install = false,
      auto_install = false,
      ignore_install = {},
      parser_install_dir = nil,
      -- highlight = ,
      ensure_installed = { "org" },
    }
    require("nvim-treesitter.configs").setup(tsconfig)

    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/orgfiles/**/*",
      org_default_notes_file = "~/orgfiles/refile.org",
    })
  end,
}
