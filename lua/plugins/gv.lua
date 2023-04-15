return {
  {
    "junegunn/gv.vim",
    keys = {
      { "<leader>gl", "<cmd>GV<cr>", desc = "Open git commits" },
    },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
}
