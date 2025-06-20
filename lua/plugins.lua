-- bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- spec
require("lazy").setup({
  install = { colorscheme = { "iceberg" } },
  spec = {
    { "wakatime/vim-wakatime" },
    { "tpope/vim-vinegar" },
    { "tpope/vim-surround",   dependencies = { "tpope/vim-repeat" } },
    { "tpope/vim-abolish",    cmd = "S" },
    { "dyng/ctrlsf.vim",      cmd = "CtrlSF" },
    { "Wansmer/treesj",       opts = {} },
    { "mason-org/mason.nvim", opts = {} },
    { "folke/lazydev.nvim",   opts = {} },
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen" },
      keys = { { "<leader>gs", "<cmd>DiffviewOpen<cr>" } },
      opts = { use_icons = false },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = 'master',
      lazy = false,
      build = ":TSUpdate",
      opts = { highlight = { enable = true } },
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
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        on_attach = function(buffer)
          local gs = require('gitsigns')

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          -- stylua: ignore start
          map("n", "]c", function() gs.nav_hunk("next") end, "Next Hunk")
          map("n", "[c", function() gs.nav_hunk("prev") end, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghP", gs.preview_hunk_inline, "Preview Hunk Inline")
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        end,
      },
    },

    {
      "ibhagwan/fzf-lua",
      keys = {
        { "<c-p>",     "<cmd>FzfLua files<cr>" },
        { "<leader>,", "<cmd>FzfLua buffers<cr>" },
        { "<leader>/", "<cmd>FzfLua live_grep<cr>" },
      },
      opts = {
        winopts = {
          border = "solid",
          fullscreen = true,
        },
        files = { previewer = false },
        buffers = { previewer = false }
      }
    },
  },
})
