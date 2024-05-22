-- local function setup_blade()
--   local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
--   parser_config.blade = {
--     install_info = {
--       url = "https://github.com/EmranMR/tree-sitter-blade",
--       files = { "src/parser.c" },
--       branch = "main",
--     },
--     filetype = "blade",
--   }
--
--   vim.filetype.add({
--     pattern = {
--       [".*%.blade%.php"] = "blade",
--     },
--   })
-- end

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
      -- setup_blade()
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
