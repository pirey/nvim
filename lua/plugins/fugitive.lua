local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("fugitive"),
    pattern = { "fugitive" },
    callback = function()
      vim.opt_local.buflisted = false
    end,
})

vim.keymap.set("n", "<leader>gs", "<cmd>G<cr><c-w>o", { desc = "Open git summary" })

return {
  {
    "tpope/vim-fugitive",
  },
}
