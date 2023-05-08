-- stolen from https://github.com/folke/dot/blob/master/nvim/lua/plugins/tools.lua
return {

  -- View git diff, file history, log
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    opts = {
      file_panel = {
        win_config = {
          position = "right"
        }
      }
    },
    keys = {
      { "<leader>gs", "<cmd>DiffviewOpen<cr>", desc = "Git status" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Git file history" },
      { "<leader>gl", "<cmd>DiffviewFileHistory<cr>", desc = "Git log history" },
    },
  },

}
