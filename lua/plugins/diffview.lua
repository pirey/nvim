-- stolen from https://github.com/folke/dot/blob/master/nvim/lua/plugins/tools.lua
return {

  -- View git diff, file history, log
  {
    "sindrets/diffview.nvim",
    cmd = {
      "OpenDiff",
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    init = function()
      vim.api.nvim_create_user_command("OpenDiff", function(opts)
        vim.cmd("DiffviewOpen " .. opts.args .. "^.." .. opts.args)
      end, { nargs = 1 })
    end,
    opts = {
      use_icons = false,
      file_panel = {
        win_config = {
          -- position = "right",
        },
      },
      default_args = {
        DiffviewFileHistory = { "--max-count=25" },
      },
      hooks = {
        view_leave = function()
          -- vim.opt.signcolumn = "yes"
        end,
        diff_buf_win_enter = function(bufnr)
          -- vim.opt_local.signcolumn = "no"
        end,
      },
    },
    keys = {
      { "<leader>gs", "<cmd>DiffviewOpen<cr>",                         desc = "Git status" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>",                desc = "Git file history" },
      { "<leader>gl", "<cmd>DiffviewFileHistory<cr>",                  desc = "Git log history" },
      { "<leader>gt", "<cmd>DiffviewFileHistory -g --range=stash<cr>", desc = "Git latest stash" },
    },
  },
}
