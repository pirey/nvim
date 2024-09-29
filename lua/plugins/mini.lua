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
  {
    "echasnovski/mini.pairs",
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
  },
  {
    "echasnovski/mini.icons",
    enabled = false,
  },
  {
    "echasnovski/mini.ai",
    enabled = false,
  },
  {
    "echasnovski/mini.indentscope",
    enabled = vim.fn.has("wsl") == 1,
    opts = {
      draw = {
        animation = function()
          return 0
        end,
      },
    },
  },
  -- {
  --   "echasnovski/mini.pairs",
  --   enabled = false,
  -- },
}
