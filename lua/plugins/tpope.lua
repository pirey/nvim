vim.cmd("autocmd! BufReadPost fugitive://* set bufhidden=delete")

vim.cmd("autocmd! FileType git lua _handle_git()")
function _G._handle_git()
  vim.cmd("setlocal foldmethod=syntax")
  vim.cmd("setlocal foldlevel=0")
  vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
end

vim.cmd("autocmd! FileType fugitive,fugitiveblame lua _handle_fugitive()")
function _G._handle_fugitive()
  vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
end

vim.cmd("autocmd! FileType dbout lua _handle_dbout()")
function _G._handle_dbout()
  vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
end

local function init_fugitive()
  -- muscle memory from the old days
  vim.api.nvim_create_user_command("Gst", "Git", { desc = "Open git status" })
  vim.keymap.set("n", ",g", "<cmd>Git<cr>", { desc = "Open fugitive" })
end

return {
  {
    "tpope/vim-fugitive",
    init = init_fugitive,
  },
  -- {
  --   "tpope/vim-surround",
  -- },
  {
    "tpope/vim-abolish",
  },
  {
    "tpope/vim-dadbod",
  },

  {
    "tommcdo/vim-fubitive",
    dependencies = { "tpope/vim-fugitive" },
  },
}
