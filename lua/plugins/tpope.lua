return {
  {
    "tpope/vim-fugitive",
    keys = {
      { ",g", "<cmd>Git<cr>", desc = "Open fugitive" },
    },
    cmd = { "Gw" },
    init = function()
      local fugitive_group = vim.api.nvim_create_augroup("FugitiveAugroup", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("BufReadPost", {
        group = fugitive_group,
        pattern = "fugitive://*",
        callback = function()
          vim.opt_local.bufhidden = "delete"
        end,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = fugitive_group,
        pattern = { "fugitive", "fugitiveblame", "git", "gitcommit" },
        callback = function()
          vim.keymap.set("n", "q", "<cmd>bd<cr>", { buffer = true })
          vim.opt_local.number = false
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = fugitive_group,
        pattern = "git",
        callback = function()
          vim.opt_local.foldmethod = "syntax"
          vim.opt_local.foldlevel = 0
        end,
      })

      -- vim.keymap.set("n", ",g", "<cmd>Git<cr>", { desc = "Open fugitive" })
    end,
  },
  -- {
  --   "tpope/vim-surround",
  -- },
  {
    "tpope/vim-abolish",
  },
  {
    "tpope/vim-dadbod",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("DadbobAugroup", { clear = true }),
        pattern = "dbout",
        callback = function()
          vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
        end,
      })
    end,
  },

  -- {
  --   "tommcdo/vim-fubitive",
  --   dependencies = { "tpope/vim-fugitive" },
  -- },
}
