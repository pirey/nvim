return {
  {
    "dyng/ctrlsf.vim",
    init = function()
      vim.g.ctrlsf_auto_close = {
        normal = 0,
        compact = 0,
      }
      vim.g.ctrlsf_auto_focus = {
        at = "start",
      }
      vim.g.ctrlsf_confirm_save = 0
      -- vim.g.ctrlsf_auto_preview = 1
      -- vim.g.ctrlsf_preview_position= "inside"
      -- vim.g.ctrlsf_default_view_mode= "compact"
      -- vim.g.ctrlsf_position= "right"

      local ctrlsf_augroup = vim.api.nvim_create_augroup("CtrlsfAugroup", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = ctrlsf_augroup,
        pattern = "ctrlsf",
        callback = function()
          vim.cmd("only")
        end,
      })
    end,
    cmd = { "CtrlSF" },
    keys = {
      { "<leader>sf", ":CtrlSF -hidden -smartcase ", desc = "Search" },
      { "<leader>sr", "<cmd>CtrlSFUpdate<cr>", desc = "Refresh Search" },
      { "<leader>sF", "<cmd>CtrlSFToggle<cr><cmd>CtrlSFUpdate<cr>", desc = "Toggle Search Result" },
    },
  },
}
