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
    { "tpope/vim-surround",   dependencies = { "tpope/vim-repeat" } },
    {
      "tpope/vim-fugitive",
      cmd = { "Git", "G", "Gw" },
      keys = {
        { "<leader>gg", "<cmd>tab Git<cr>", },
      },
      init = function ()
        vim.cmd([[
          cabbrev <expr> git getcmdtype() == ':' && getcmdline() =~# '^git' ? 'Git' : 'git'
        ]])
      end
    },
    { "tpope/vim-abolish",    cmd = "S" },
    { "mason-org/mason.nvim", opts = {} },
    { "tiagovla/scope.nvim", config = true },
    { "folke/lazydev.nvim",   ft = "lua",                           opts = {} },
    {
      "sindrets/diffview.nvim",
      cmd = { "DiffviewOpen" },
      keys = {
        { "<leader>gs", "<cmd>DiffviewOpen<cr>" },
        { "<leader>gl", "<cmd>DiffviewFileHistory<cr>" },
        { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>" },
        { "<leader>gt", "<cmd>DiffviewFileHistory -g --range=stash<cr>", desc = "Git latest stash" },
      },
      opts = {
        use_icons = false,
        default_args = {
          DiffviewFileHistory = { "--max-count=25" },
        },
      },
    },
    {
      'stevearc/oil.nvim',
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      keys = {
        { "-", "<cmd>Oil<cr>" }
      }
    },
    {
      "Wansmer/treesj",
      keys = { { "<leader>j", "<cmd>TSJToggle<cr>" } },
      opts = { use_default_keymaps = false },
    },
    {
      "echasnovski/mini.bufremove",
      version = "*",
      keys = {
        { "<leader>x", function() require("mini.bufremove").delete() end }
      }
    },
    {
      "nvim-treesitter/nvim-treesitter",
      branch = "master",
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
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("phpactor")
        vim.lsp.enable("vtsls")
        vim.lsp.enable("clangd")
        vim.lsp.enable("tailwindcss")

        vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open local diagnostics" })
        vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open global diagnostics" })
        vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "Format document" })
      end
    },
    {
      "ibhagwan/fzf-lua",
      keys = {
        { "<leader>f",  "<cmd>FzfLua files<cr>" },
        { "<leader>b",  "<cmd>FzfLua buffers<cr>" },
        { "<leader>/",  "<cmd>FzfLua live_grep<cr>" },
        { "<leader>?",  "<cmd>FzfLua blines<cr>" },
        { "<leader>.",  "<cmd>FzfLua resume<cr>" },
        { "<leader>o",  "<cmd>FzfLua lsp_document_symbols<cr>" },
        { "<leader>O",  "<cmd>FzfLua lsp_workspace_symbols<cr>" },
        { "<leader>dd", "<cmd>FzfLua lsp_document_diagnostics<cr>" },
        { "<leader>dD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>" },
      },
      opts = {
        winopts = {
          border = "solid",
          fullscreen = true,
          preview = {
            border = "single"
          }
        },
        colorschemes = { winopts = { fullscreen = false } },
      }
    },
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        on_attach = function(buffer)
          local gs = require("gitsigns")

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]c", function() gs.nav_hunk("next") end, "Next Hunk")
          map("n", "[c", function() gs.nav_hunk("prev") end, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "Toggle Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
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
        engines = {
          ripgrep = {
            extraArgs = "--smart-case",
          }
        }
      }
    },
    { "folke/tokyonight.nvim", opts = { style = "night" } },
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

            -- etc
            vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur", { link = "Title" })
            vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { link = "Title" })
            vim.api.nvim_set_hl(0, "FzfLuaPathLineNr", { link = "Title" })

            -- transparent
            -- vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "NONE", bg = "NONE" }) -- squiggly ~
            -- vim.api.nvim_set_hl(0, "Normal", { fg = "NONE", bg = "NONE" }) -- squiggly ~
            -- vim.api.nvim_set_hl(0, "SignColumn", { fg = "NONE", bg = "NONE" }) -- squiggly ~
            -- vim.api.nvim_set_hl(0, "FoldColumn", { fg = "NONE", bg = "NONE" }) -- squiggly ~
            -- patch_group_pattern("GitGutter", { bg = "NONE" })
            -- patch_group_pattern("Diagnostic", { bg = "NONE" })
          end,
          group = custom_highlight,
        })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
          callback = function()
            if vim.bo.modified then
              vim.cmd("hi! link StatusLine StatusLineNC")
            else
              vim.cmd("hi! link StatusLine StatusLine")  -- or your preferred default
            end
          end,
        })

        -- fancy
        vim.opt.signcolumn = "yes"
        vim.opt.cmdheight = 0
        vim.opt.laststatus = 3
        vim.cmd.colorscheme("iceberg")
      end,
    },
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      ---@module "blink.cmp"
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
          ["<C-_>"] = { "show" },
        },
        cmdline = { enabled = false },
        sources = {
          per_filetype = {
            sql = { "dadbod", "snippets", "buffer" },
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
        { "tpope/vim-dadbod",                     lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
      },
      cmd = { "DBUI" },
    },
  },
})
