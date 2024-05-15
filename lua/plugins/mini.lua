return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = ",as", -- Add surrounding in Normal and Visual modes
        delete = ",ds", -- Delete surrounding
        find = ",fs", -- Find surrounding (to the right)
        find_left = ",Fs", -- Find surrounding (to the left)
        highlight = ",hs", -- Highlight surrounding
        replace = ",cs", -- Replace surrounding
        update_n_lines = ",ns", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        ",x",
        function()
          require("mini.bufremove").delete(0)
        end,
        desc = "Delete buffer",
      },
      {
        ",w",
        function()
          vim.cmd("close")
        end,
        desc = "Close window",
      },
      {
        ",d",
        function()
          vim.cmd("bd")
        end,
        desc = "Delete buffer",
      },
      {
        ",b",
        function()
          vim.cmd("b#")
        end,
        desc = "Previous buffer",
      },
    },
  },
  -- {
  --   "echasnovski/mini.indentscope",
  --   enabled = false,
  -- },
  -- {
  --   "echasnovski/mini.pairs",
  --   enabled = false,
  -- },
}
