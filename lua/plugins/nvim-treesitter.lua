local function setup_blade()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.blade = {
    install_info = {
      url = "https://github.com/EmranMR/tree-sitter-blade",
      files = { "src/parser.c" },
      branch = "main",
    },
    filetype = "blade",
  }

  vim.filetype.add({
    pattern = {
      [".*%.blade%.php"] = "blade",
    },
  })
end
return {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("orgmode").setup_ts_grammar()
    setup_blade()
    local opts = {
      ignore_install = { "help" },
      ensure_installed = { "org" },
      highlight = {
        enable = true,
        -- disable = { "markdown", "json" },
        additional_vim_regex_highlighting = { "org" },
      },
      indent = {
        enable = true,
      },
    }
    require("nvim-treesitter.configs").setup(opts)
  end,
}
