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
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    {
      "Wansmer/treesj",
      keys = { { "<leader>j", "<cmd>TSJToggle<cr>" } },
      opts = { use_default_keymaps = false },
    },
    {
      'echasnovski/mini.bufremove',
      version = '*',
      keys = {
        { "<leader>x", function() require('mini.bufremove').delete() end }
      }
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
      opts = {
        highlight = { enable = true },
        indent = { enable = true },
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
        vim.lsp.enable('clangd')

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
        winopts = { border = "solid", fullscreen = true },
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
      lazy = true,
      opts = { style = "night" },
    },
    {
      "cocopon/iceberg.vim",
      lazy = false,
      priority = 1000,
      init = function()
        --- patch_hl adds highlight definition without replacing original highlight
        --- useful when we need to override highlight and retain existing definition
        ---
        --- @param hlg string Highlight group name
        --- @param patch table Override highlight
        local function patch_hl(hlg, patch)
          local hl = vim.api.nvim_get_hl(0, {
            name = hlg,
          })
          vim.api.nvim_set_hl(0, hlg, vim.tbl_deep_extend("keep", patch, hl))
        end

        local function patch_group_pattern(hlg_pattern, patch)
          for _, hlg in pairs(vim.fn.getcompletion(hlg_pattern, "highlight")) do
            patch_hl(hlg, patch)
          end
        end

        local custom_highlight = vim.api.nvim_create_augroup("CustomIceberg", { clear = true })
        vim.api.nvim_create_autocmd("ColorScheme", {
          pattern = "iceberg",
          callback = function()
            local bg = "#161821"
            local fg_dark = "#3e445e" -- from StatusLineNC
            local bg_dark = "#0f1117" -- from StatusLineNC
            local fg = "#c6c8d1"
            local comment_fg = "#6b7089"
            local linenr_bg = "#1e2132"
            local linenr_fg = "#444b71"
            local visual = "#272c42"

            vim.api.nvim_set_hl(0, "NonText", { link = "Comment" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg, bg = bg }) -- squiggly ~
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = fg_dark, bold = true })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = bg })
            vim.api.nvim_set_hl(0, "FoldColumn", { bg = bg, fg = fg_dark })

            -- line number
            vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg, bold = true })
            vim.api.nvim_set_hl(0, "LineNr", { bg = bg, fg = linenr_fg })

            -- colored text in diff
            vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#45493e", fg = "NONE" })
            vim.api.nvim_set_hl(0, "DiffChange", { bg = visual, fg = "NONE" })
            vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#53343b", fg = "NONE" })
            vim.api.nvim_set_hl(0, "DiffText", { bg = "#384851", fg = "NONE" })

            -- float
            vim.api.nvim_set_hl(0, "Pmenu", { bg = linenr_bg, fg = fg })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = linenr_bg, fg = fg })

            -- Italic jsx/html tag attribute @tag.attribute.tsx htmlArg
            vim.api.nvim_set_hl(0, "Constant", { fg = "#a093c7", italic = true })

            patch_group_pattern("GitGutter", { bg = bg })
            patch_group_pattern("Diagnostic", { bg = bg })
          end,
          group = custom_highlight,
        })

        -- fancy
        vim.opt.signcolumn = "yes"
        vim.opt.cmdheight = 0
        vim.cmd.colorscheme("iceberg")
      end,
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
        cmdline = { enabled = false },
        sources = {
          per_filetype = {
            sql = { 'snippets', 'dadbod', 'buffer' },
          },
          providers = {
            dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          },
        },
      },
    },
    {
      "kristijanhusak/vim-dadbod-ui",
      dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
      },
      cmd = { "DBUI" },
    }
  },
})
