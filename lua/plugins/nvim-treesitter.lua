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
    setup_blade()
    local opts = {
      ignore_install = { "help" },
      ensure_installed = { "http", "json" },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    }
    require("nvim-treesitter.configs").setup(opts)
  end,
}
