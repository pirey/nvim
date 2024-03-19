-- TODO: sudden error after upgrade? not sure how to fix
-- temporariy switch to neorg
return {
  {
    "nvim-orgmode/orgmode",
    enabled = false,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = true },
    },
    event = "VeryLazy",
    config = function()
      -- Load treesitter grammar for org
      require("orgmode").setup_ts_grammar()

      -- Setup treesitter
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
        ensure_installed = { "org" },
      })

      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/org/**/*",
        org_default_notes_file = "~/org/refile.org",
        org_todo_keywords = { "TODO", "IN_PROGRESS", "|", "DONE", "CANCELLED" },
        org_startup_folded = "showeverything",
      })
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    enabled = true,
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
