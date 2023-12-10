vim.g.maplocalleader = ","
return {
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.summary"] = {},
          ["core.journal"] = {
            config = {
              strategy = "flat",
              workspace = "journal",
            },
          },
          ["core.dirman"] = {
            -- config = { engine = "nvim-cmp" },
            config = {
              workspaces = {
                notes = "~/norg/notes",
                work = "~/norg/work",
                journal = "~/norg/journal",
              },
              default_workspace = "notes",
            },
          },
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
