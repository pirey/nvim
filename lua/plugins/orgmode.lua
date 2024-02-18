return {
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true },
    },
    event = "VeryLazy",
    opts = {
      org_agenda_files = "~/org/**/*",
      org_default_notes_file = "~/org/refile.org",
      org_todo_keywords = { "TODO", "IN_PROGRESS", "REVIEW", "QA", "|", "DONE", "CANCELLED" },
      org_startup_folded = "showeverything",
    },
  },
  {
    "akinsho/org-bullets.nvim",
    dependencies = { "nvim-orgmode/orgmode" },
    opts = {
      symbols = {
        checkboxes = {
          todo = { "✗", "OrgTODO" },
        },
      },
    },
  },
}
