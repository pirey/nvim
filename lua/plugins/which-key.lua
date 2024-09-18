if vim.fn.has("wsl") then
  vim.opt.timeoutlen = 1000
end
return {
  "folke/which-key.nvim",
  enabled = vim.fn.has("wsl") == 0,
  opts = {
    icons = {
      mappings = false,
      rules = false,
      colors = false,
    },
  },
}
