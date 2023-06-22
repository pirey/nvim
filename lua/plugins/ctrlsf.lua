return {
  {
    "dyng/ctrlsf.vim",
    init = function()
      vim.api.nvim_set_var("ctrlsf_auto_close", {
        normal = 0,
        compact = 0,
      })
      vim.api.nvim_set_var("ctrlsf_auto_focus", {
        at = "start",
      })
      vim.api.nvim_set_var("ctrlsf_confirm_save", 0)
      -- vim.api.nvim_set_var("ctrlsf_auto_preview", 1)
      -- vim.api.nvim_set_var("ctrlsf_preview_position", "inside")
      -- vim.api.nvim_set_var("ctrlsf_default_view_mode", "compact")
      -- vim.api.nvim_set_var("ctrlsf_position", "right")

      vim.cmd([[
        augroup ctrlsf_autocmd
          autocmd!
          autocmd FileType ctrlsf only
        augroup END
      ]])
    end,
    cmd = { "CtrlSF" },
    keys = {
      { "<leader>sf", ":CtrlSF -hidden -smartcase ", desc = "Search" },
      { "<leader>sF", "<cmd>CtrlSFToggle<cr>", desc = "Search Result" },
    },
  },
}
