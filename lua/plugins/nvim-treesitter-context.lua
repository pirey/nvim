-- vim.keymap.set("n", "[c", function()
--   require("treesitter-context").go_to_context()
-- end, { silent = true })

return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
