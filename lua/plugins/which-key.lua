return {
  "folke/which-key.nvim",
  enabled = vim.fn.has("wsl") ~= 1,
  opts = {
    icons = {
      mappings = false,
      rules = false,
    },
  },
}
