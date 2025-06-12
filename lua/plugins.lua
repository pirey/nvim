-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- spec
require("lazy").setup({
  spec = {
    { "wakatime/vim-wakatime" },
    { "tpope/vim-vinegar" },
    { "tpope/vim-surround", dependencies = { "tpope/vim-repeat" }},
    { "tpope/vim-fugitive", cmd = { "G", "Git" }},
    { "tpope/vim-abolish", cmd = "S" },
    { "dyng/ctrlsf.vim", cmd = "CtrlSF" },
    { "junegunn/fzf", keys = {{ "<c-p>", "<cmd>FZF!<cr>" }}}
  },
  install = { colorscheme = { "iceberg" }},
})
