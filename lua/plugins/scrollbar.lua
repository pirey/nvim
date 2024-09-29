return {
  {
    "petertriho/nvim-scrollbar",
    enabled = vim.fn.has("wsl") == 1,
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    opts = {
      handle = {
        text = " ",
        blend = 30, -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        color = nil,
        color_nr = nil, -- cterm
        highlight = "Visual",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
      },
    },
    config = function(_, opts)
      require("scrollbar").setup(opts)
      require("scrollbar.handlers.search").setup({
        override_lens = function() end,
      })
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
}

-- local function get_minor_version()
--   local v = vim.version()
--   print("minor: " .. v.minor)
--   return v.minor
-- end
--
-- if get_minor_version() < 10 then
--   return {
--     {
--       "petertriho/nvim-scrollbar",
--       config = true,
--     },
--   }
-- else
--   return {
--     {
--       "lewis6991/satellite.nvim",
--       config = true,
--     },
--   }
-- end
