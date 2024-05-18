return {
  "folke/trouble.nvim",
  init = function()
    vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
  end,
}
