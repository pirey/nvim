return {
  "joaomsa/telescope-orgmode.nvim",
  "pirey/telescope-orgmode.nvim",
  branch = "fix-deprecated-error-message",
  dependencies = {
    { "nvim-orgmode/orgmode", lazy = true },
    { "nvim-telescope/telescope.nvim", lazy = true },
  },
  init = function()
    require("telescope").load_extension("orgmode")
    vim.keymap.set("n", "<leader>os", require("telescope").extensions.orgmode.search_headings)
  end,
}
