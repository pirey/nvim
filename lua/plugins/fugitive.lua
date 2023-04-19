if true then return {} end

local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Define a buffer-local keymap for the current buffer only
local function add_buffer_keymap(mode, lhs, rhs)
  vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, {})

  vim.api.nvim_buf_attach(0, false, {
      on_detach = function ()
        vim.api.nvim_buf_del_keymap(0, mode, lhs)
      end
  })
end

vim.api.nvim_create_autocmd("FileType", {
    group = augroup("fugitive"),
    pattern = { "fugitive" },
    callback = function()
      vim.opt_local.buflisted = false
      add_buffer_keymap("n", "q", "<cmd>bd<cr>")
    end,
})

vim.keymap.set("n", "<leader>gs", "<cmd>G<cr><c-w>o", { desc = "Open git summary" })

return {
  {
    "tpope/vim-fugitive",
  },
}
