vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", function()
  if vim.diagnostic.is_disabled() then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end, {
  silent = true,
  noremap = true,
  desc = "Toggle diagnostic",
})

return {}
