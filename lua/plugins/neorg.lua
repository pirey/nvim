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
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          },
          ["core.summary"] = {},
          ["core.tempus"] = {},
          ["core.journal"] = {
            config = {
              strategy = "flat",
              workspace = "work",
            },
          },
          ["core.dirman"] = {
            -- config = { engine = "nvim-cmp" },
            config = {
              workspaces = {
                notes = "~/norg/notes",
                work = "~/norg/work",
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
