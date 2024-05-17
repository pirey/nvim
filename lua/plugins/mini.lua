return {
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = ",as", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = ",fs", -- Find surrounding (to the right)
        find_left = ",Fs", -- Find surrounding (to the left)
        highlight = ",hs", -- Highlight surrounding
        replace = "cs", -- Replace surrounding
        update_n_lines = ",ns", -- Update `n_lines`
      },
    },
  },
  -- {
  --   "echasnovski/mini.indentscope",
  --   opts = {},
  -- },
  -- {
  --   "echasnovski/mini.pairs",
  --   enabled = false,
  -- },
}
