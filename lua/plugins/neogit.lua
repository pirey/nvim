return {
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    dependencies = {
      "sindrets/diffview.nvim",
    },
    opts = {
      disable_commit_confirmation = true,
      integrations = {
        diffview = true,
      },
    },
  },
}
