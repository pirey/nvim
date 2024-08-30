local lazyvim_util = require("lazyvim.util")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
-- local trouble = require("trouble.providers.telescope")
local transform_mod = require("telescope.actions.mt").transform_mod

-- custom actions

local custom_actions = transform_mod({
  open_and_resume = function(prompt_bufnr)
    actions.select_default(prompt_bufnr)
    require("telescope.builtin").resume()
  end,
  -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1679797700
  select_one_or_multi = function(prompt_bufnr)
    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
      require("telescope.actions").close(prompt_bufnr)
      for _, j in pairs(multi) do
        if j.path ~= nil then
          vim.cmd(string.format("%s %s", "edit", j.path))
        end
      end
    else
      require("telescope.actions").select_default(prompt_bufnr)
    end
  end,
})

local open_files = "<cmd>Telescope find_files<cr>"

return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  init = function()
    local autocmd_group = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })
    vim.api.nvim_create_autocmd("WinLeave", {
      group = autocmd_group,
      callback = function()
        if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
        end
      end,
    })

    -- local temp_showtabline
    local temp_laststatus

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopeFindPre",
      group = autocmd_group,
      callback = function()
        -- temp_showtabline = vim.o.showtabline
        temp_laststatus = vim.o.laststatus
        -- vim.o.showtabline = 0
        vim.o.laststatus = 0
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "TelescopePrompt",
      group = autocmd_group,
      callback = function()
        vim.api.nvim_create_autocmd("BufLeave", {
          group = autocmd_group,
          callback = function()
            -- vim.o.laststatus = 3
            -- vim.o.showtabline = 2
            vim.o.laststatus = temp_laststatus
            -- vim.o.showtabline = temp_showtabline
          end,
        })
      end,
    })
  end,
  keys = {
    -- git
    { "<leader>gs", false },
    { "<leader>gc", false },
    { "<leader>sR", false },
    { "<leader>;", "<cmd>Telescope commands<cr>", desc = "Fuzzy commands" },
    { "<leader>gL", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gS", "<cmd>Telescope git_status<CR>", desc = "status" },
    { "<leader>b/", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "search current file" },
    {
      "<leader>gb",
      lazyvim_util.pick("git_branches", {
        show_remote_tracking_branches = false,
      }),
      desc = "Open git branches",
    },
    { "<leader>gB", lazyvim_util.pick("git_branches"), desc = "Open git branches with remotes" },
    -- { "<leader>gB", Util.telescope("git_branches", {show_remote_tracking_branches = true} }), desc = "Open git branches" },

    -- files
    { "<leader><space>", open_files, desc = "Find Files (cwd)" },
    { "<c-p>", open_files, desc = "Find Files (cwd)" },
    { "<leader>p", open_files, desc = "Find Files (cwd)" },
    { "<leader>ff", open_files, desc = "Find Files (cwd)" },
    { "<leader>fr", lazyvim_util.pick("oldfiles", { cwd_only = true }), desc = "Recent project files" },
    { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    {
      "<leader>,",
      lazyvim_util.pick("buffers", { select_current = true, cwd = vim.fn.getcwd() }),
      desc = "Select Buffer",
    },
    {
      "<leader>ss",
      "<cmd>Telescope lsp_document_symbols<cr>",
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      desc = "Goto Symbol (Workspace)",
    },
  },
  -- TODO: tidy prompt title
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules" },
      layout_strategy = "bottom_pane",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          width = { padding = 0 },
          height = { padding = 0 },
          preview_width = 0.5,
        },
        bottom_pane = {
          prompt_position = "bottom",
          sorting_strategy = "descending",
        },
      },
      -- border = false,
      -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      borderchars = { "─", "", "", "", "", "", "", "" },
      -- results_title = false,
      -- prompt_title = false,
      -- winblend = 0,
      -- path_display = { "truncate" },
      path_display = {
        "filename_first",
      },
      preview = {
        hide_on_startup = true,
        treesitter = {
          disable = { "markdown" },
        },
      },
      mappings = {
        i = {
          ["<c-c>"] = false,
          ["<esc>"] = actions.close,
          ["<c-j>"] = actions.move_selection_next,
          ["<c-k>"] = actions.move_selection_previous,
          ["<c-t>"] = actions_layout.toggle_preview,
          -- ["<c-t>"] = trouble.smart_open_with_trouble,
          ["<c-l>"] = custom_actions.open_and_resume,
          ["zl"] = actions.preview_scrolling_right,
          ["zh"] = actions.preview_scrolling_left,
          ["<cr>"] = custom_actions.select_one_or_multi,
          ["<c-x>"] = actions.delete_buffer,
        },
      },
    },
    pickers = {
      lsp_references = {
        fname_width = 100,
        show_line = false, -- don't show current line
        trim_text = true,
      },
    },
  },
}
