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
  ui = { size = { width = 1, height = 1 } },
  spec = {
    { "wakatime/vim-wakatime" },
    { "tpope/vim-vinegar" },
    { "tpope/vim-surround",   dependencies = { "tpope/vim-repeat" } },
    { "tpope/vim-abolish",    cmd = "S" },
    { "tpope/vim-fugitive",   cmd = { "G", "Gw", "Git" } },
    { "mason-org/mason.nvim", opts = {} },
    { "folke/lazydev.nvim",   opts = {} },
    {
      "Wansmer/treesj",
      keys = { { "<leader>j", "<cmd>TSJToggle<cr>" } },
      opts = { use_default_keymaps = false },
    },
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen" },
      keys = {
        { "<leader>gs", "<cmd>DiffviewOpen<cr>" },
        { "<leader>gl", "<cmd>DiffviewFileHistory<cr>" },
        { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>" },
      },
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

        vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open local diagnostics" })
        vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open global diagnostics" })
      end
    },
    {
      "ibhagwan/fzf-lua",
      keys = {
        { "<leader>f", "<cmd>FzfLua files<cr>" },
        { "<leader>b", "<cmd>FzfLua buffers<cr>" },
        { "<leader>/", "<cmd>FzfLua live_grep<cr>" },
      },
      opts = {
        winopts = { border = "solid", fullscreen = true, preview = { border = "single" } },
        files = { previewer = false },
        buffers = { previewer = false },
        colorschemes = { winopts = { fullscreen = false } },
      }
    },
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        on_attach = function(buffer)
          local gs = require('gitsigns')

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]c", function() gs.nav_hunk("next") end, "Next Hunk")
          map("n", "[c", function() gs.nav_hunk("prev") end, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "Toggle Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
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
      "MagicDuck/grug-far.nvim",
      cmd = "GrugFar",
      keys = { { "<leader>sr", "<cmd>GrugFar<cr>" } },
      opts = {
        icons = { enabled = false },
        transient = true,
        windowCreationCommand = "tab split",
      }
    },
    {
      "folke/tokyonight.nvim",
      opts = { style = "night" },
    },
    {
      'saghen/blink.cmp',
      dependencies = { 'rafamadriz/friendly-snippets' },
      version = '1.*',
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        signature = {
          enabled = true,
          window = { show_documentation = true },
        },
        completion = {
          accept = {
            auto_brackets = {
              enabled = false,
            },
          },
          menu = {
            draw = {
              columns = { { "label", "label_description", gap = 1 }, { "kind" } }
            },
          },
          documentation = { auto_show = true },
        },
        keymap = {
          -- same as ctrl+/
          ['<C-_>'] = { "show" },
        },
        cmdline = { enabled = false }
      },
    }
  },
})
