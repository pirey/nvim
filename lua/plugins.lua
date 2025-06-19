-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- spec
require("lazy").setup({
  spec = {
    { "wakatime/vim-wakatime" },
    { "tpope/vim-vinegar" },
    { "tpope/vim-surround",   dependencies = { "tpope/vim-repeat" } },
    { "tpope/vim-fugitive",   cmd = { "G", "Git" } },
    { "tpope/vim-abolish",    cmd = "S" },
    { "lewis6991/gitsigns.nvim", opts = {} },
    { "dyng/ctrlsf.vim",      cmd = "CtrlSF" },
    {
      "junegunn/fzf",
      keys = { { "<c-p>", "<cmd>FZF<cr>" } },
      init = function()
        vim.g.fzf_layout = { window = "enew" }
      end
    },
    { "mason-org/mason.nvim", opts = {} },
    { "folke/lazydev.nvim", opts = {} },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      opts = {
        highlight = {
          enable = true
        }
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('phpactor')
        vim.lsp.enable('vtsls')
      end
    },
  },
  install = { colorscheme = { "iceberg" } },
})
