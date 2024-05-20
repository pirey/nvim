local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  buffer_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
  diff_mode = function()
    return vim.o.diff == true
  end,
}

local opts = {
  options = {
    theme = {
      normal = {
        a = "StatusLine", -- "Normal",
        b = "StatusLine", -- "Normal",
        c = "StatusLine", -- "Normal",
        x = "StatusLine", -- "Normal",
        y = "StatusLine", -- "Normal",
        z = "StatusLine", -- "Normal",
      },
    },
    global_status = true,
    always_divide_middle = false,
    -- Disable sections and component separators
    -- component_separators = "",
    -- section_separators = "",
    disabled_filetypes = {
      statusline = { "neo-tree", "git", "fugitive" },
      winbar = { "neo-tree", "DiffviewFiles", "git" },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function insert_left(component)
  table.insert(opts.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function insert_right(component)
  table.insert(opts.sections.lualine_x, component)
end

insert_left({
  "branch",
  icon = "",
})

-- TODO: adjust color for diff and diagnostics (and filetype)
-- insert_left({
--   "diff",
--   cond = conditions.hide_in_width,
-- })
--
-- insert_left({
--   "diagnostics",
--   sources = { "nvim_diagnostic" },
--   -- symbols = { error = " ", warn = " ", info = " " },
--   symbols = { error = "E", warn = "W", info = "I", hint = "H" },
-- })

insert_left({
  "filename",
  path = 1,
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
insert_left({
  "%=",
})

local function get_max_line()
  return vim.fn.line("$")
end

local function get_tmux_char()
  local result = io.popen("tmux list-panes -F '#F' | grep Z")

  if result ~= nil and result:read("*a") ~= "" then
    result:close()
    return "■"
  else
    return ""
  end
end

insert_left({
  function()
    local char_register = vim.fn.reg_recording()
    if #char_register > 0 then
      return "REC @" .. char_register
    end
    return ""
  end,
  color = "Visual",
})

insert_left({
  "searchcount",
  color = "Search",
})

insert_left({
  "selectioncount",
  color = "Visual",
})

insert_left({
  "location",
  cond = conditions.buffer_not_empty,
})

insert_left({
  get_max_line,
  cond = conditions.buffer_not_empty,
})

insert_left({
  "encoding",
})

insert_left({
  "%y",
  -- "filetype",
  -- colored = false,
  -- color = "StatusLine",
})

insert_left({
  get_tmux_char,
  padding = { left = 1, right = 1 }, -- We don't need space before this
  cond = function()
    return os.getenv("TMUX") ~= nil
  end,
})

return {
  "nvim-lualine/lualine.nvim",
  opts = opts,
}
