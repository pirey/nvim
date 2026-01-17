local function setup(fn)
  if fn then
    fn()
  end
end

vim.pack.add({
  { src = "https://github.com/wakatime/vim-wakatime" },
  { src = "https://github.com/tpope/vim-repeat" },
  { src = "https://github.com/tpope/vim-surround" },
  { src = "https://github.com/tpope/vim-abolish" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/sindrets/winshift.nvim" },
  { src = "https://github.com/sindrets/diffview.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/Wansmer/treesj" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/folke/lazydev.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/hedyhli/outline.nvim" },
  { src = "https://github.com/pirey/mini.omnipick" },
  { src = "https://github.com/nvim-mini/mini.files" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/nvim-mini/mini.visits" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/MagicDuck/grug-far.nvim" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/saghen/blink.cmp", version = "v1.8.0" },
  { src = "https://github.com/saghen/blink.indent" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/mfussenegger/nvim-lint" },
  { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  { src = "https://github.com/tpope/vim-dadbod" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
  { src = "https://github.com/nvzone/showkeys" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/oysandvik94/curl.nvim" },
  { src = "https://github.com/nvim-orgmode/orgmode" },
  { src = "https://github.com/sudo-tee/opencode.nvim" },
  { src = "https://github.com/supermaven-inc/supermaven-nvim" },
  { src = "https://github.com/navarasu/onedark.nvim" },
  { src = "https://github.com/cocopon/iceberg.vim" },
  { src = "https://github.com/Mofiqul/vscode.nvim" },
})

-- fugitive {{{
setup(function()
  vim.keymap.set("n", "<leader>gg", "<cmd>tab Git<cr>", { silent = true })
  vim.keymap.set("n", "<leader>gv", "<cmd>vert Git<cr>", { silent = true })
  vim.keymap.set("n", "<leader>gl", "<cmd>tab Git log --no-merges<cr>", { silent = true })

  vim.cmd([[
  cabbrev <expr> git getcmdtype() == ':' && getcmdline() =~# '^git' ? 'Git' : 'git'
]])
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "git",
    callback = function()
      vim.keymap.set("n", "gq", "<Cmd>bd<CR>", { buffer = true })
    end,
  })
end)
-- }}}

-- mason {{{
setup(function()
  require("mason").setup()
  local mason_reg = require("mason-registry")

  local mason_pkgs = {
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
  }

  mason_reg.refresh(function()
    for _, tool in ipairs(mason_pkgs) do
      local p = mason_reg.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end)
-- }}}

-- winshift {{{
setup(function()
  require("winshift").setup()
  vim.keymap.set("n", "<c-w><c-m>", "<cmd>WinShift<cr>", { silent = true })
  vim.keymap.set("n", "<c-w>m", "<cmd>WinShift<cr>", { silent = true })
  vim.keymap.set("n", "<c-w>X", "<cmd>WinShift swap<cr>", { silent = true, desc = "Swap window" })
end)
-- }}}

-- diffview {{{
setup(function()
  require("diffview").setup({
    use_icons = false,
    default_args = {
      DiffviewFileHistory = { "--max-count=100" },
    },
    file_panel = {
      listing_style = "list",
      win_config = {
        position = "top",
        height = 16,
      },
    },
    file_history_panel = {
      win_config = {
        position = "top",
        height = 16,
      },
    },
    keymaps = {
      file_panel = {
        { "n", "cc", "<cmd>Git commit<cr>", { desc = "Commit staged changes" } },
        { "n", "gq", "<cmd>tabclose<cr>", { desc = "Close tab" } },
      },
      file_history_panel = {
        { "n", "gq", "<cmd>tabclose<cr>", { desc = "Close tab" } },
      },
    },
  })
  vim.keymap.set("n", "<leader>gs", "<cmd>DiffviewOpen<cr>", { silent = true })
  vim.keymap.set("n", "<leader>gy", "<cmd>DiffviewFileHistory<cr>", { silent = true })
  vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { silent = true })
  vim.keymap.set(
    "n",
    "<leader>gt",
    "<cmd>DiffviewFileHistory -g --range=stash<cr>",
    { silent = true, desc = "Git latest stash" }
  )
end)
-- }}}

-- oil {{{
setup(function()
  require("oil").setup({
    view_options = { show_hidden = true },
    keymaps = {
      ["<localleader>t"] = { "actions.open_terminal", mode = "n" },
      [">"] = { "actions.select", mode = "n" },
      ["<"] = { "actions.parent", mode = "n" },
    },
  })
  vim.keymap.set("n", "<leader>-", "<cmd>Oil<cr>", { silent = true })
  vim.keymap.set("n", "<leader><leader>-", "<cmd>Oil .<cr>", { silent = true })
end)
-- }}}

-- treesj {{{
setup(function()
  require("treesj").setup({
    use_default_keymaps = false,
  })
  vim.keymap.set("n", "<leader>j", "<cmd>TSJToggle<cr>", { silent = true, desc = "Join/split line" })
end)
-- }}}

-- treesitter {{{
setup(function()
  require("nvim-treesitter.configs").setup({
    modules = {},
    sync_install = false,
    ignore_install = {},
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "lua",
      "html",
      "blade",
      "php",
    },
  })
  -- TODO: run :TSUpdate whenever pack updated/installed
end)
-- }}}

-- lazydev {{{
setup(function()
  require("lazydev").setup()
end)
-- }}}

-- lspconfig {{{
setup(function()
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
    "gopls",
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
end)
-- }}}

-- outline {{{
setup(function()
  require("outline").setup()
  vim.keymap.set("n", "<leader>O", "<cmd>Outline<CR>", { silent = true, desc = "Toggle Outline" })
end)
-- }}}

-- mini_files {{{
setup(function()
  vim.keymap.set(
    "n",
    "<leader>e",
    "<cmd>lua require('mini.files').open(vim.fn.getcwd())<cr>",
    { silent = true, desc = "Open file browser" }
  )
end)
-- }}}

-- mini_pick {{{
setup(function()
  local minipick = require("mini.pick")
  local miniextra = require("mini.extra")
  local minivisits = require("mini.visits")
  local omnipick = require("mini.omnipick")

  minipick.setup({
    source = { show = minipick.default_show },
    mappings = {
      scroll_left = "<BS>",
      delete_char = "<c-h>",
    },
  })

  minivisits.setup()
  miniextra.setup()
  omnipick.setup({ show_icons = false })

  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(items, opts, on_choice)
    local cursor_anchor = vim.fn.screenrow() < 0.5 * vim.o.lines and "NW" or "SW"
    return minipick.ui_select(items, opts, on_choice, {
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
  vim.keymap.set("n", "<leader>k", "<cmd>Pick keymaps<cr>", { silent = true })
  vim.keymap.set("n", "<leader>b", "<cmd>Pick buffers<cr>", { silent = true })
  vim.keymap.set("n", "<leader>.", "<cmd>Pick resume<cr>", { silent = true })
  vim.keymap.set("n", "<leader>d", "<cmd>Pick diagnostic scope='current'<cr>", { silent = true })
  vim.keymap.set("n", "<leader>s", "<cmd>Pick lsp scope='document_symbol'<cr>", { silent = true })
  vim.keymap.set("n", "<leader>r", "<cmd>Pick lsp scope='references'<cr>", { silent = true })
  vim.keymap.set("n", "<leader>h", "<cmd>Pick help<cr>", { silent = true })
  vim.keymap.set("n", "<leader>l", "<cmd>Pick hl_groups<cr>", { silent = true })
  vim.keymap.set("n", "<leader>,", "<cmd>Pick grep_live<cr>", { silent = true })
  vim.keymap.set("n", "<leader>/", "<cmd>Pick buf_lines scope='current'<cr>", { silent = true })
  vim.keymap.set("n", "<leader>?", "<cmd>Pick buf_lines<cr>", { silent = true })
  vim.keymap.set("n", '<leader>"', "<cmd>Pick visit_paths<cr>", { silent = true })
  vim.keymap.set("n", "<leader>'", "<cmd>Pick oldfiles current_dir=true<cr>", { silent = true })
  vim.keymap.set("n", "<leader>f", "<cmd>Pick omni<cr>", { silent = true })
end)
-- }}}

-- gitsigns {{{
setup(function()
  require("gitsigns").setup({
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
  })
end)
-- }}}

-- grug_far {{{
setup(function()
  require("grug-far").setup({
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
  })
  vim.keymap.set("n", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
  vim.keymap.set("x", "<leader><c-f>", "<cmd>GrugFar<cr>", { silent = true })
end)
-- }}}

-- blink_cmp {{{
setup(function()
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
end)
-- }}}

-- blink_indent {{{
setup(function()
  require("blink.indent").setup({
    static = {
      char = "┊",
    },
    scope = {
      char = "│",
      highlights = {
        "BlinkIndentScope",
      },
    },
  })
end)
-- }}}

-- conform {{{
setup(function()
  require("conform").setup({
    formatters_by_ft = {
      lua = { "stylua" },
      php = { "php_cs_fixer" },
      blade = { "blade-formatter" },
      json = { "prettierd", "prettier", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
    },
  })
  vim.keymap.set("n", "<leader>F", function()
    require("conform").format({ async = true })
  end)
end)
-- }}}

-- nvim_lint {{{
setup(function()
  require("lint").linters_by_ft = vim.tbl_extend("force", require("lint").linters_by_ft, {
    typescriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    php = { "phpcs" },
  })
  vim.keymap.set("n", "<leader>L", function()
    require("lint").try_lint()
  end)
end)
-- }}}

-- colorizer {{{
setup(function()
  vim.o.termguicolors = true
  require("colorizer").setup()
end)
-- }}}

-- dadbod {{{
setup(function()
  vim.g.db_ui_execute_on_save = 0
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
      vim.keymap.set("n", "<leader>s", "<Plug>(DBUI_ExecuteQuery)<Cmd>write<CR>", { silent = true })
    end,
  })
end)
-- }}}

-- showkeys {{{
setup(function()
  require("showkeys").setup()
end)
-- }}}

-- curl {{{
setup(function()
  require("curl").setup()
end)
-- }}}

-- orgmode {{{
setup(function()
  require("orgmode").setup({
    org_use_property_inheritance = false,
    hyperlinks = { sources = {} },
    mappings = {
      org = {
        org_toggle_checkbox = "<leader>o<tab>", -- <c-space> is reserved for tmux prefix
      },
    },
    win_split_mode = "vertical",
    org_agenda_files = { "~/org/**/*", "~/vault-org/**/*" },
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
            org_agenda_files = { "~/vault-org/projects/**/*" }, -- Can define files outside of the default org_agenda_files
          },
          {
            type = "tags_todo",
            org_agenda_overriding_header = "Project TODO",
            org_agenda_files = { "~/vault-org/projects/**/*" },
            -- org_agenda_tag_filter_preset = 'NOTES-REFACTOR' -- Show only headlines with NOTES tag that does not have a REFACTOR tag. Same value providad as when pressing `/` in the Agenda view
          },
        },
      },
    },
  })
  vim.keymap.set("n", "<leader>oc", "<cmd>Org capture<cr>", { silent = true })
  vim.keymap.set("n", "<leader>oa", "<cmd>Org agenda<cr>", { silent = true })
end)
-- }}}

-- opencode {{{
setup(function()
  require("opencode").setup({
    keymap_prefix = "<leader>a",
    ui = {
      output = { auto_scroll = true },
      icons = { preset = "text" },
    },
  })
end)
-- }}}

-- supermaven {{{
setup(function()
  require("supermaven-nvim").setup({})
end)
-- }}}

-- themes {{{
require("themes.onedark")
require("themes.iceberg")
require("themes.vscode")
-- }}}

vim.cmd.colorscheme("onedark")

--- vim:fdm=marker
