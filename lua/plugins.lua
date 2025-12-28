-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.isdirectory(lazypath) == 0 then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

local wakatime = { "wakatime/vim-wakatime" }
local surround = { "tpope/vim-surround", dependencies = { "tpope/vim-repeat" } }
local fugitive = {
  "tpope/vim-fugitive",
  cmd = { "Git", "G", "Gw" },
  keys = {
    { "<leader>gg", "<cmd>tab Git<cr>" },
    { "<leader>gv", "<cmd>vert Git<cr>" },
  },
  init = function()
    vim.cmd([[
          cabbrev <expr> git getcmdtype() == ':' && getcmdline() =~# '^git' ? 'Git' : 'git'
        ]])
  end,
}
local abolish = { "tpope/vim-abolish" }
local mason = {
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
}
local winshift = {
  "sindrets/winshift.nvim",
  keys = {
    { "<c-w><c-m>", "<cmd>WinShift<cr>" },
    { "<c-w>m", "<cmd>WinShift<cr>" },
    { "<c-w>X", "<cmd>WinShift swap<cr>", desc = "Swap window" },
  },
  opts = {},
}
local diffview = {
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
}
local oil = {
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
}
local treesj = {
  "Wansmer/treesj",
  keys = { { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Join/split line" } },
  opts = { use_default_keymaps = false },
}
local treesitter = {
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
}
local lazydev = { "folke/lazydev.nvim", ft = "lua", opts = {} }
local lspconfig = {
  "neovim/nvim-lspconfig",
  config = function()
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
    vim.lsp.config("tailwindcss", {
      settings = {
        tailwindCSS = {
          classFunctions = { "tw", "clsx", "tw\\.[a-z-]+", "twMerge" },
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
}
local outline = {
  "hedyhli/outline.nvim",
  keys = { { "<leader>O", "<cmd>Outline<CR>", desc = "Toggle Outline" } },
  config = function()
    require("outline").setup()
  end,
}
local mini_files = {
  "nvim-mini/mini.files",
  version = "*",
  keys = {
    { "<leader>e", "<cmd>lua require('mini.files').open(vim.fn.getcwd())<cr>", desc = "Open file browser" },
  },
}
local mini_pick = {
  "nvim-mini/mini.pick",
  version = "*",
  dependencies = {
    { "nvim-mini/mini.extra", version = "*" },
    { "nvim-mini/mini.visits", version = "*" },
  },
  cmd = { "Pick" },
  keys = {
    { "<leader>k", "<cmd>Pick keymaps<cr>" },
    { "<leader>b", "<cmd>Pick buffers<cr>" },
    { "<leader>.", "<cmd>Pick resume<cr>" },
    { "<leader>d", "<cmd>Pick diagnostic scope='current'<cr>" },
    { "<leader>s", "<cmd>Pick lsp scope='document_symbol'<cr>" },
    { "<leader>r", "<cmd>Pick lsp scope='references'<cr>" },
    { "<leader>h", "<cmd>Pick help<cr>" },
    { "<leader>l", "<cmd>Pick hl_groups<cr>" },
    { "<leader>,", "<cmd>Pick grep_live<cr>" },
    { "<leader>/", "<cmd>Pick buf_lines scope='current'<cr>" },
    { "<leader>?", "<cmd>Pick buf_lines<cr>" },
    { "<leader>'", "<cmd>Pick visit_paths<cr>" },
    { '<leader>"', "<cmd>Pick oldfiles current_dir=true<cr>" },
    {
      "<leader>p",
      function()
        require("mini.pick").builtin.cli({
          command = { "fd", "--hidden", "-E", ".git", "--type", "f" },
        }, {
          source = { name = "Files" },
        })
      end,
      desc = "Find files",
    },
    {
      "<leader><leader>d",
      function()
        require("mini.pick").builtin.cli({
          command = { "fd", "--hidden", "-E", ".git", "--type", "d" },
        }, {
          source = { name = "Dir" },
        })
      end,
      desc = "Find dir",
    },
    {
      "<leader>f",
      function()
        -- https://www.reddit.com/r/neovim/comments/1d9d4uo/my_combined_files_directories_and_recents_picker/
        -- remove cwd prefix from visited paths
        local short_path = function(path)
          local cwd = vim.fn.getcwd()
          if path == cwd then
            return path
          end
          if not vim.startswith(path, cwd) then
            return vim.fn.fnamemodify(path, ":~")
          end
          local res = path:sub(cwd:len() + 1):gsub("^/+", "")
          return res
        end

        -- merge arrays but only add items from the right if not contained in left
        local merge = function(left, right)
          local result = {}
          for _, item in ipairs(left) do
            table.insert(result, item)
          end
          for _, item in ipairs(right) do
            if vim.tbl_contains(result, item) then
              goto continue
            end
            table.insert(result, item)
            ::continue::
          end
          return result
        end

        local recents = MiniVisits.list_paths(vim.fn.getcwd())

        -- these are usually filtered out by gitignore but I want them in the results
        local env = vim.fs.find({ ".env", ".envrc" }, { path = vim.fn.getcwd() })

        MiniPick.builtin.cli({
          -- find files and directories with fd
          command = { "fd", "--hidden", "--type", "f", "--type", "d", "--exclude", ".git" },
          -- probably not intended for it but I use the postprocess callback to
          -- combine fd results with recents from mini.visits
          postprocess = function(items)
            local items_with_env = merge(items, env)
            local shortened_recents = vim.tbl_map(short_path, recents)
            return merge(shortened_recents, items_with_env)
          end,
        }, {
          source = {
            name = "Files & Dirs",
            show = function(buf_id, items, query)
              MiniPick.default_show(buf_id, items, query)
            end,
            choose = vim.schedule_wrap(MiniPick.default_choose),
          },
        })
      end,
    },
  },
  config = function()
    local pick = require("mini.pick")
    local extra = require("mini.extra")
    local visits = require("mini.visits")

    pick.setup({
      source = { show = pick.default_show },
      mappings = {
        scroll_left = "<BS>",
        delete_char = "<c-h>",
      },
    })

    visits.setup()
    extra.setup()

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
}
local gitsigns = {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(buffer)
      local gs = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map("n", "]g", function()
        ---@diagnostic disable-next-line: param-type-mismatch
        gs.nav_hunk("next")
      end, "Next Hunk")
      map("n", "[g", function()
        ---@diagnostic disable-next-line: param-type-mismatch
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
        ---@diagnostic disable-next-line: param-type-mismatch
        gs.diffthis("~")
      end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      map({ "n" }, "<leader>gb", function()
        local tabpage = vim.api.nvim_get_current_tabpage()
        local wins = vim.api.nvim_tabpage_list_wins(tabpage)
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "gitsigns-blame" then
            vim.api.nvim_set_current_win(win)
            return
          end
        end
        gs.blame()
      end, "GitSigns Blame")
    end,
  },
}
local grug_far = {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    { "<leader><c-f>", "<cmd>GrugFar<cr>", mode = { "n" } },
    {
      "<leader><c-f>",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = { "x" },
    },
  },
  opts = {
    icons = { enabled = false },
    transient = true,
    windowCreationCommand = "tab split",
    engines = {
      ripgrep = {
        extraArgs = "--smart-case --hidden --glob=!.git",
      },
    },
    openTargetWindow = {
      preferredLocation = vim.opt.splitright and "right" or "left",
    },
  },
}
local blink_cmp = {
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
}
local blink_indent = {
  "saghen/blink.indent",
  --- @module 'blink.indent'
  --- @type blink.indent.Config
  opts = {
    static = {
      char = "┊",
    },
    scope = {
      char = "│",
      highlights = {
        "BlinkIndentScope",
      },
    },
  },
}
local conform = {
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
}
local nvim_lint = {
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
      typescriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      php = { "phpcs" },
    })
  end,
}
local colorizer = {
  "norcalli/nvim-colorizer.lua",
  cmd = { "ColorizerToggle", "ColorizerAttachToBuffer", "ColorizerDetachFromBuffer" },
}
local dadbod_ui = {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = { "DBUI" },
  keys = {
    { "<leader>s", "<Plug>(DBUI_ExecuteQuery)<Cmd>write<CR>", ft = { "sql", "mysql", "plsql" } },
  },
  init = function()
    vim.g.db_ui_execute_on_save = 0
  end,
}
local showkeys = { "nvzone/showkeys", cmd = "ShowkeysToggle" }
local curl = {
  "oysandvik94/curl.nvim",
  cmd = { "CurlOpen" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {},
}
local orgmode = {
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
}
local opencode = {
  "sudo-tee/opencode.nvim",
  lazy = false,
  config = function()
    require("opencode").setup({
      keymap_prefix = "<leader>a",
      keymap = {
        session_picker = {
          new_session = { "<C-s>" }, -- Create and switch to a new session in the session picker
        },
      },
      ui = {
        icons = {
          preset = "text",
        },
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
    "nvim-mini/mini.pick",
  },
}
local supermaven = {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({})
  end,
}
local theme_onedark = require("themes.onedark")
local theme_iceberg = require("themes.iceberg")
local theme_vscode = require("themes.vscode")
local theme_tokyonight = {
  "folke/tokyonight.nvim",
  opts = { style = "night" },
}

require("lazy").setup({
  install = { colorscheme = { "default" } },
  ui = { size = { width = 1, height = 1 } },
  spec = {
    -- EDITING
    surround,
    fugitive,
    abolish,
    treesj,
    conform,
    nvim_lint,
    blink_cmp,
    blink_indent,

    -- UI
    winshift,
    diffview,
    oil,
    outline,
    mini_files,
    mini_pick,
    gitsigns,
    grug_far,

    -- TOOLS
    mason,
    treesitter,
    lazydev,
    lspconfig,

    -- AI
    opencode,
    supermaven,

    -- ETC
    wakatime,
    colorizer,
    showkeys,
    orgmode,
    dadbod_ui,
    curl,

    -- THEMES
    theme_onedark,
    theme_iceberg,
    theme_vscode,
    theme_tokyonight,
  },
})
