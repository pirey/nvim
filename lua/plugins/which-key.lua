return {
  "folke/which-key.nvim",
  enabled = vim.fn.has("wsl") == 0,
  opts = {
    icons = {
      mappings = false,
      rules = false,
    },
  },
}
