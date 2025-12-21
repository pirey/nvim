-- pageline: Custom tabline plugin
require("pageline").setup({
  ft_titles = {
    checkhealth = "Health",
    git = "Git",
    fugitive = "Fugitive",
    dbui = "DBUI",
    DiffviewFiles = "Diffview",
    DiffviewFileHistory = "Git Log",
    opencode = "OpenCode",
    ["grug-far"] = "Search",
  },
  buftype_titles = {
    terminal = "Term",
  },
})
