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
        { "<leader>wg", "<cmd>vert Git<cr>" },
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
          "mmdc",
          "stylua",
          "clangd",
          "lua-language-server",
          "prettier",
          "tailwindcss-language-server",
          "vtsls",
          "phpactor",
          "phpcs",
          "php-cs-fixer",
          "blade-formatter",
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
          DiffviewFileHistory = { "--max-count=100" },
        },
        keymaps = {
          file_panel = {
            {
              "n",
              "cc",
              "<Cmd>Git commit <bar> wincmd K<CR>",
              { desc = "Commit staged changes" },
            },
          },
        },
      },
    },
    {
      "stevearc/oil.nvim",
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
      keys = {
        { "-", "<cmd>Oil<cr>" },
        { "<leader>-", "<cmd>Oil .<cr>" },
      },
      config = function()
        require("oil").setup({
          view_options = { show_hidden = true },
          keymaps = {
            ["<localleader>t"] = { "actions.open_terminal", mode = "n" },
            [">"] = { "actions.select", mode = "n" },
            ["<"] = { "actions.parent", mode = "n" },
          },
        })
      end,
    },
    {
      "Wansmer/treesj",
      keys = { { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join/split line" } },
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
        ensure_installed = {
          "mermaid",
          "javascript",
          "typescript",
          "tsx",
          "lua",
          "html",
          "blade",
          "php",
        },
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end,
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        vim.lsp.config("lua_ls", {
          settings = {
            Lua = {
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
            },
          },
        })
        vim.lsp.config("phpactor", {
          init_options = {
            ["language_server.diagnostic_ignore_codes"] = {
              "worse.docblock_missing_return_type",
              "worse.missing_return_type",
            },
          },
        })
        vim.lsp.config("vtsls", {
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
              },
            },
          },
        })

        vim.lsp.enable({
          "lua_ls",
          "phpactor",
          "clangd",
          "tailwindcss",
          "vtsls",
        })

        vim.keymap.set("n", "<leader>ql", vim.diagnostic.setloclist, { desc = "Open local diagnostics" })
        vim.keymap.set("n", "<leader>qq", vim.diagnostic.setqflist, { desc = "Open global quickfix diagnostics" })

        -- disable semantic highlight
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.server_capabilities.semanticTokensProvider then
              client.server_capabilities.semanticTokensProvider = nil
            end
          end,
        })
      end,
    },
    {
      "dmtrKovalenko/fff.nvim",
      build = "cargo build --release",
      opts = {
        prompt = " ",
        title = "Files",
        layout = {
          prompt_position = "top",
          preview_position = "bottom",
          preview_size = 0.6,
          width = math.min(100 / vim.o.columns, 0.95),
          height = math.min(55 / vim.o.lines, 0.95),
        },
        preview = {
          enabled = vim.o.lines >= 50,
        },
        keymaps = {
          close = { "<esc>", "<c-c>" },
          move_up = { "<c-p>", "<c-k>" },
          move_down = { "<c-n>", "<c-j>" },
          preview_scroll_up = "<c-b>",
          preview_scroll_down = "<c-f>",
        },
        icons = { enabled = false },
      },
      cmd = { "FFFFind" },
      keys = {
        {
          "<leader>f",
          function()
            require("fff").find_files() -- or find_in_git_root() if you only want git files
          end,
          desc = "Open file picker",
        },
      },
    },
    {
      "echasnovski/mini.pick",
      version = "*",
      dependencies = { "echasnovski/mini.extra", version = "*" },
      cmd = { "Pick" },
      keys = {
        -- { "<leader>f", "<cmd>Pick files<cr>" },
        { "<leader>k", "<cmd>Pick keymaps<cr>" },
        { "<leader>b", "<cmd>Pick buffers<cr>" },
        { "<leader>.", "<cmd>Pick resume<cr>" },
        { "<leader>e", "<cmd>Pick diagnostic scope='current'<cr>" },
        { "<leader>E", "<cmd>Pick diagnostic<cr>" },
        { "<leader>s", "<cmd>Pick lsp scope='document_symbol'<cr>" },
        { "<leader>r", "<cmd>Pick lsp scope='references'<cr>" },
        { "<leader>'", "<cmd>Pick oldfiles current_dir=true<cr>" },
        { "<leader>h", "<cmd>Pick help<cr>" },
        { "<leader>,", "<cmd>Pick grep_live<cr>" },
        { "<leader>/", "<cmd>Pick buf_lines<cr>" },
        {
          "<leader>a",
          function()
            require("mini.pick").builtin.cli({
              command = { "fd", "--hidden", "--type", "d", "--type", "f", "-E", ".git" },
            })
          end,
          desc = "Find files and dirs",
        },
        {
          "<leader>d",
          function()
            require("mini.pick").builtin.cli({
              command = { "fd", "--hidden", "--type", "d", "-E", ".git" },
            })
          end,
          desc = "Find dirs",
        },
      },
      config = function()
        local pick = require("mini.pick")

        local win_config = function()
          local cols, lines = vim.o.columns, vim.o.lines - vim.o.cmdheight
          if vim.o.laststatus > 0 then
            lines = lines - 1
          end
          if vim.o.showtabline == 2 or (vim.o.showtabline == 1 and vim.fn.tabpagenr("$") > 1) then
            lines = lines - 1
          end

          local w = math.min(100, math.floor(cols * 0.95))
          local h = math.min(30, math.floor(lines * 0.95))

          return {
            width = w,
            height = h,
            row = 3,
            col = math.floor((cols - w) / 2),
            anchor = "NW",
            border = "rounded",
          }
        end

        pick.setup({
          source = { show = pick.default_show },
          mappings = {
            scroll_left = "<BS>",
            delete_char = "<c-h>",
          },
          window = { config = win_config },
        })

        require("mini.extra").setup()

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.ui.select = function(items, opts, on_choice)
          local cursor_anchor = vim.fn.screenrow() < 0.5 * vim.o.lines and "NW" or "SW"
          return pick.ui_select(items, opts, on_choice, {
            options = { content_from_bottom = cursor_anchor == "SW" },
            window = {
              config = {
                relative = "cursor",
                anchor = cursor_anchor,
                row = cursor_anchor == "NW" and 1 or 0,
                col = 0,
                width = math.min(60, math.floor(0.618 * vim.o.columns)),
                height = math.min(math.max(#items, 1), math.floor(0.45 * vim.o.columns)),
              },
            },
          })
        end
      end,
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
      keys = { { "<leader>?", "<cmd>GrugFar<cr>" } },
      opts = {
        icons = { enabled = false },
        transient = true,
        windowCreationCommand = "tab split",
        engines = {
          ripgrep = {
            extraArgs = "--smart-case --hidden --glob=!.git",
          },
        },
      },
    },
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      config = function()
        require("blink.cmp").setup({
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
            documentation = {
              auto_show = true,
            },
          },
          keymap = {
            -- same as ctrl+/
            ["<C-_>"] = { "show" },
          },
          cmdline = { enabled = false },
          sources = {
            per_filetype = {
              org = { "orgmode", "snippets" },
              sql = { "dadbod", "snippets" },
            },
            providers = {
              dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
              orgmode = { name = "Orgmode", module = "orgmode.org.autocompletion.blink", fallbacks = { "buffer" } },
            },
          },
        })
      end,
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
          blade = { "blade-formatter" },
        },
      },
      config = function(_, opts)
        local prettier_ft = {
          "json",
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
    {
      "mfussenegger/nvim-lint",
      keys = {
        {
          "<leader>L",
          function()
            require("lint").try_lint()
          end,
        },
      },
      config = function()
        local lint = require("lint")
        lint.linters_by_ft = vim.tbl_extend("force", lint.linters_by_ft, {
          typescriptreact = { "eslint" },
          typescript = { "eslint" },
          javascript = { "eslint" },
          javascriptreact = { "eslint" },
          php = { "phpcs" },
        })
      end,
    },

    -- ETC

    { "kevinhwang91/nvim-bqf", ft = "qf" },
    {
      "terrastruct/d2-vim",
      ft = "d2",
    },
    {
      "kristijanhusak/vim-dadbod-ui",
      dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
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
      "nvim-orgmode/orgmode",
      ft = { "org" },
      cmd = { "Org" },
      keys = {
        { "<leader>oc", "<cmd>Org capture<cr>" },
        { "<leader>oa", "<cmd>Org agenda<cr>" },
      },
      opts = {
        mappings = {
          org = {
            org_toggle_checkbox = "<leader>o<tab>", -- <c-space> is reserved for tmux prefix
          },
        },
        win_split_mode = "vertical",
        org_agenda_files = "~/org/**/*",
        org_default_notes_file = "~/org/tasks.org",
        org_todo_keywords = { "TODO", "STARTED", "|", "DONE" },
        org_adapt_indentation = false,
        org_deadline_warning_days = 3,
        org_capture_templates = {
          n = {
            description = "Note",
            template = "* %?\n  %u",
            target = "~/org/dropnotes.org",
          },
        },
        org_agenda_custom_commands = {
          p = {
            description = "Projects Agenda",
            types = {
              {
                type = "agenda",
                org_agenda_overriding_header = "Projects Agenda",
                org_agenda_files = { "~/org/projects/**/*" }, -- Can define files outside of the default org_agenda_files
              },
              {
                type = "tags_todo",
                org_agenda_overriding_header = "Project TODO",
                org_agenda_files = { "~/org/projects/**/*" },
                -- org_agenda_tag_filter_preset = 'NOTES-REFACTOR' -- Show only headlines with NOTES tag that does not have a REFACTOR tag. Same value providad as when pressing `/` in the Agenda view
              },
            },
          },
        },
      },
    },

    -- THEMES

    { "folke/tokyonight.nvim", lazy = true, opts = { style = "night" } },
    require("themes.onedark"),
    require("themes.iceberg"),
  }, -- spec
})
