return {
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      -- "lewis6991/gitsigns.nvim"
    },
    config = function()
      require("scrollbar").setup()
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
