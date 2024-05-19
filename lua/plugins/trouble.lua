return {
  "folke/trouble.nvim",
  init = function()
    vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
  end,
  opts = {
    height = vim.fn.winheight(0) / 2,
  },
}
