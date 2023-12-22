return {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter", lazy = true },
  },
  event = "VeryLazy",
  opts = {
    org_agenda_files = "~/org/**/*",
    org_default_notes_file = "~/org/refile.org",
    org_todo_keywords = { "TODO", "IN_PROGRESS", "|", "DONE", "CANCELLED" },
    org_startup_folded = "showeverything",
  },
}
