-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- plugin spec
require("lazy").setup({
  install = { colorscheme = { "default" } },
  ui = { size = { width = 1, height = 1 } },
  spec = {
    { "wakatime/vim-wakatime" },
    { "tpope/vim-surround", dependencies = { "tpope/vim-repeat" } },
    {
      "tpope/vim-fugitive",
      cmd = { "Git", "G", "Gw" },
      keys = {
        { "<leader>gg", "<cmd>tab Git<cr>" },
      },
      init = function()
        vim.cmd([[
          cabbrev <expr> git getcmdtype() == ':' && getcmdline() =~# '^git' ? 'Git' : 'git'
        ]])
      end,
    },
    { "tpope/vim-abolish", cmd = "S" },
    {
      "mason-org/mason.nvim",
      opts_extend = { "ensure_installed" },
      opts = {
        ensure_installed = {
          "stylua",
          "clangd",
          "lua-language-server",
          "prettier",
          "tailwindcss-language-server",
          "vtsls",
          "phpactor",
          "phpcs",
          "php-cs-fixer",
        },
      },
      config = function(_, opts)
        -- stolen from folke's drawer
        require("mason").setup(opts)
        local registry = require("mason-registry")

        registry.refresh(function()
          for _, tool in ipairs(opts.ensure_installed) do
            local p = registry.get_package(tool)
            if not p:is_installed() then
              p:install()
            end
          end
        end)
      end,
    },
    {
      "sindrets/winshift.nvim",
      keys = {
        { "<c-w><c-m>", "<cmd>WinShift<cr>" },
        { "<c-w>m", "<cmd>WinShift<cr>" },
        { "<c-w>X", "<cmd>WinShift swap<cr>", desc = "Swap window" },
      },
      opts = {},
    },
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
      "stevearc/oil.nvim",
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {
        view_options = { show_hidden = true },
        keymaps = {
          ["<localleader>t"] = { "actions.open_terminal", mode = "n" },
        },
      },
      keys = {
        { "-", "<cmd>Oil<cr>" },
      },
    },
    {
      "Wansmer/treesj",
      keys = { { "<leader>j", "<cmd>TSJToggle<cr>" } },
      opts = { use_default_keymaps = false },
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
      end,
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
        vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Open global quickfix diagnostics" })
      end,
    },
    {
      "ibhagwan/fzf-lua",
      keys = {
        { "<leader>f", "<cmd>FzfLua files<cr>" },
        { "<leader>b", "<cmd>FzfLua buffers<cr>" },
        { "<leader>/", "<cmd>FzfLua live_grep<cr>" },
        { "<leader>?", "<cmd>FzfLua blines<cr>" },
        { "<leader>.", "<cmd>FzfLua resume<cr>" },
        { "<leader>o", "<cmd>FzfLua lsp_document_symbols<cr>" },
        { "<leader>O", "<cmd>FzfLua lsp_workspace_symbols<cr>" },
        { "<leader>dd", "<cmd>FzfLua lsp_document_diagnostics<cr>" },
        { "<leader>dD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>" },
        { "<leader>r", "<cmd>FzfLua lsp_references<cr>" },
        { "<leader>R", "<cmd>FzfLua oldfiles<cr>" },
        { "<leader>t", "<cmd>FzfLua tabs show_unlisted=true<cr>" },
      },
      opts = {
        winopts = {
          border = "solid",
          fullscreen = true,
          preview = {
            border = "single",
          },
        },
        colorschemes = { winopts = { fullscreen = false } },
        oldfiles = {
          include_current_session = true,
          cwd_only = true,
        },
      },
    },
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        on_attach = function(buffer)
          local gs = require("gitsigns")

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
          end

          map("n", "]g", function()
            gs.nav_hunk("next")
          end, "Next Hunk")
          map("n", "[g", function()
            gs.nav_hunk("prev")
          end, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "Toggle Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghP", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
          map("n", "<leader>ghb", function()
            gs.blame_line({ full = true })
          end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function()
            gs.diffthis("~")
          end, "Diff This ~")
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
          },
        },
      },
    },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    { "folke/tokyonight.nvim", lazy = true, opts = { style = "night" } },
    {
      "projekt0n/github-nvim-theme",
      name = "github-theme",
      lazy = true,
      config = function()
        require("github-theme").setup({
          groups = {
            all = {
              StatusLine = { link = "TabLine" },
              StatusLineNC = { link = "TabLineFill" },
            },
          },
        })
      end,
    },
    { "nordtheme/vim", lazy = true }, -- like iceberg, but lower contrast
    {
      "cocopon/iceberg.vim", -- like nord, but higher contrast
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
            local fg = "#c6c8d1"
            local bg = "#161821"
            local fg_dark = "#3e445e" -- from StatusLineNC
            local bg_dark = "#0f1117" -- from StatusLineNC
            local statusline_fg = fg
            local statusline_bg = bg_dark
            local comment_fg = "#6b7089"
            local border_fg = fg_dark
            local float_bg = bg
            local float_fg = fg
            local float_border = border_fg
            local linenr_fg = "#444b71"
            local linenr_bg = bg
            local visual = "#272c42"
            local diff_add = "#45493e"
            local diff_change = visual
            local diff_delete = "#53343b"
            local tabline_fg = statusline_fg
            local tabline_bg = statusline_bg
            local diff_text = "#384851"

            if vim.o.background == "light" then
              bg = "#e8e9ec"
              fg = "#33374c"
              fg_dark = "#cad0de"
              bg_dark = "#8b98b6"
              border_fg = fg_dark
              float_bg = bg
              float_fg = fg
              float_border = fg
              linenr_fg = "#9fa7bd"
              linenr_bg = bg
              diff_add = "#d4dbd1"
              diff_change = "#ced9e1"
              diff_delete = "#e3d2da"
              diff_text = "#acc5d3"
              tabline_fg = "#8b98b6"
              tabline_bg = "#cad0de"
              statusline_fg = fg
              statusline_bg = tabline_bg
            end

            vim.api.nvim_set_hl(0, "NonText", { link = "Comment" })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg, bg = bg }) -- squiggly ~
            vim.api.nvim_set_hl(0, "WinSeparator", { fg = border_fg, bold = true })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = linenr_bg })
            vim.api.nvim_set_hl(0, "FoldColumn", { bg = bg, fg = fg_dark })
            vim.api.nvim_set_hl(0, "StatusLine", { fg = statusline_fg, bg = statusline_bg })
            vim.api.nvim_set_hl(0, "TabLineFill", { fg = tabline_fg, bg = tabline_bg })

            -- line number
            vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg, bold = true })
            vim.api.nvim_set_hl(0, "LineNr", { bg = linenr_bg, fg = linenr_fg })

            -- colored text in diff
            vim.api.nvim_set_hl(0, "DiffAdd", { bg = diff_add, fg = "NONE" })
            vim.api.nvim_set_hl(0, "DiffChange", { bg = diff_change, fg = "NONE" })
            vim.api.nvim_set_hl(0, "DiffDelete", { bg = diff_delete, fg = "NONE" })
            vim.api.nvim_set_hl(0, "DiffText", { bg = diff_text, fg = "NONE" })

            -- float
            vim.api.nvim_set_hl(0, "Pmenu", { bg = float_bg, fg = float_fg })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = float_bg, fg = float_fg })

            -- float border
            vim.api.nvim_set_hl(0, "FloatBorder", { bg = float_bg, fg = float_border })
            vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = float_bg, fg = float_border })
            vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = float_bg, fg = float_border })
            vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = float_bg, fg = float_border })
            vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { bg = float_bg, fg = float_border })

            -- Italic jsx/html tag attribute @tag.attribute.tsx htmlArg
            vim.api.nvim_set_hl(0, "Constant", { fg = "#a093c7", italic = true })

            patch_group_pattern("GitGutter", { bg = linenr_bg })
            patch_group_pattern("Diagnostic", { bg = linenr_bg })

            -- etc
            vim.api.nvim_set_hl(0, "FzfLuaBufFlagCur", { link = "Title" })
            vim.api.nvim_set_hl(0, "FzfLuaHeaderText", { link = "Title" })
            vim.api.nvim_set_hl(0, "FzfLuaPathLineNr", { link = "Title" })
            vim.api.nvim_set_hl(0, "FzfLuaHeaderBind", { link = "Title" })
            vim.api.nvim_set_hl(0, "FzfLuaTabMarker", { link = "Title" })
            vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = border_fg })

            patch_group_pattern("DiagnosticUnderline", { undercurl = true })

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

        vim.opt.background = "dark"
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
              columns = { { "label", "label_description", gap = 1 }, { "kind" } },
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
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
      },
      keys = {
        { "<leader>db", "<cmd>tab DBUI<cr>" },
      },
      cmd = { "DBUI" },
      init = function()
        vim.g.db_ui_execute_on_save = 0
      end,
    },
    { "nvzone/showkeys", cmd = "ShowkeysToggle" },
    {
      "oysandvik94/curl.nvim",
      cmd = { "CurlOpen" },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      opts = {},
    },
    {
      "stevearc/conform.nvim",
      dependencies = { "mason-org/mason.nvim" },
      keys = {
        {
          "<leader>F",
          function()
            require("conform").format({ async = true })
          end,
        },
      },
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          php = { "php_cs_fixer" },
        },
      },
      config = function(_, opts)
        local prettier_ft = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "css",
        }

        for _, ft in ipairs(prettier_ft) do
          opts.formatters_by_ft[ft] = { "prettierd", "prettier", stop_after_first = true }
        end

        require("conform").setup(opts)
      end,
    },
  }, -- spec
})
