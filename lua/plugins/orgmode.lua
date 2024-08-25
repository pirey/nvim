return {
  {
    "nvim-orgmode/orgmode",
    lazy = true,
    ft = "org",
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/org/**/*",
        org_default_notes_file = "~/org/refile.org",
        org_todo_keywords = { "BLOCKED", "TODO", "IN_PROGRESS", "|", "DONE", "CANCELLED" },
        org_startup_folded = "showeverything",
      })

      -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
      -- add `org` to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    ft = "org",
    dependencies = { "nvim-orgmode/orgmode" },
    opts = {
      symbols = {
        checkboxes = {
          todo = { "✗", "OrgTODO" },
        },
      },
    },
  },
  {
    -- "joaomsa/telescope-orgmode.nvim",
    "pirey/telescope-orgmode.nvim",
    enabled = false,
    ft = "org",
    branch = "fix-deprecated-error-message",
    dependencies = {
      { "nvim-orgmode/orgmode", lazy = true },
      { "nvim-telescope/telescope.nvim", lazy = true },
    },
    init = function()
      require("telescope").load_extension("orgmode")
      vim.keymap.set("n", "<leader>os", require("telescope").extensions.orgmode.search_headings)
    end,
  },
}
