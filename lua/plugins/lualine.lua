-- return {
--   {
--     "nvim-lualine/lualine.nvim",
--     opts = {
--       options = {
--         component_separators = { left = "", right = "" },
--         section_separators = { left = "", right = "" },
--       },
--     }
--   },
-- }

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require("lualine")
local colors = require("tokyonight.colors").moon()
local custom_filename = require("lualine.components.filename"):extend()
local highlight = require("lualine.highlight")

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
}

function custom_filename:init(options)
  custom_filename.super.init(self, options)
  self.options.path = 0 -- use this for filename only
  -- self.options.path = 1 -- use this for relative filename
  self.options.cond = conditions.buffer_not_empty
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      { fg = colors.bg, bg = colors.fg, gui = "bold" },
      "filename_status_saved",
      self.options
    ),
    modified = highlight.create_component_highlight_group(
      { fg = colors.bg, bg = colors.green, gui = "bold" },
      "filename_status_modified",
      self.options
    ),
  }
  if self.options.color == nil then
    self.options.color = ""
  end
  self.options.separator = { right = "" }
end

function custom_filename:update_status()
  local data = custom_filename.super.update_status(self)
  data = highlight.component_format_highlight(
    vim.bo.modified and self.status_colors.modified or self.status_colors.saved
  ) .. data
  return data
end

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
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
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- ins_left {
--   function()
--     return '▊'
--   end,
--   color = { fg = colors.blue }, -- Sets highlighting of component
--   padding = { left = 0, right = 1 }, -- We don't need space before this
-- }

-- ins_left({
--   -- mode component
--   function()
--     -- return ''
--     -- return "▊ "
--     -- return " ■ "
--     return "█"
--   end,
--   color = function()
--     -- auto change color according to neovims mode
--     local mode_color = {
--       n = colors.fg_dark,
--       i = colors.green,
--       v = colors.blue,
--       -- [''] = colors.blue,
--       V = colors.blue,
--       c = colors.magenta,
--       no = colors.red,
--       s = colors.orange,
--       S = colors.orange,
--       [""] = colors.orange,
--       ic = colors.yellow,
--       R = colors.violet,
--       Rv = colors.violet,
--       cv = colors.red,
--       ce = colors.red,
--       r = colors.cyan,
--       rm = colors.cyan,
--       ["r?"] = colors.cyan,
--       ["!"] = colors.red,
--       t = colors.red,
--     }
--     return { fg = mode_color[vim.fn.mode()] }
--   end,
--   padding = { right = 1 },
-- })

-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }

-- ins_left {
--   -- Lsp server name .
--   function()
--     local icon = ' LSP: '
--     local msg = ''
--     local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
--     local clients = vim.lsp.get_active_clients()
--     if next(clients) == nil then
--       return msg
--     end
--     for _, client in ipairs(clients) do
--       local filetypes = client.config.filetypes
--       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--         return icon .. client.name
--       end
--     end
--     return msg
--   end,
--   -- icon = ' LSP:',
--   color = { fg = colors.cyan, gui = 'bold' },
-- }

ins_left(custom_filename)

-- file dirname
ins_left({
  function()
    local dirname = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':~:.')
    local percentage = vim.o.columns > 200 and 0.45 or 0.25
    local maxlen = math.floor(vim.o.columns * percentage)

    if vim.api.nvim_strwidth(dirname) >= maxlen then
      return ".." .. string.sub(dirname, -maxlen)
    end
    return dirname
  end,
  color = { fg = colors.fg_dark, bg = colors.bg_highlight },
  -- separator = { left = '', right = '' },
  separator = { left = "", right = "" },
  cond = conditions.buffer_not_empty,
})

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
})

-- display cwd if opening empty file
ins_left({
  function()
    local home = os.getenv("HOME")
    local cwd = vim.fn.getcwd()
    if home == nil then
      return cwd
    end
    return string.gsub(cwd, home, "~")
  end,
  cond = conditions.buffer_empty,
  color = { fg = colors.fg_dark, bg = colors.bg_highlight },
  separator = { left = "", right = "" },
})

-- ins_left({
--   function()
--     return require("nvim-navic").get_location({
--       highlight = false,
--       -- depth_limit = 2,
--     })
--   end,
--   fmt = function(str)
--     local percentage = vim.o.columns > 200 and 0.20 or 0.15
--     local maxlen = math.floor(vim.o.columns * percentage)
--     if vim.api.nvim_strwidth(str) >= maxlen then
--       local trimmed = string.sub(str, -maxlen)
--       return ".." .. string.gsub(trimmed, "^[\\.]+", "")
--     end
--     return str
--   end,
--   cond = function()
--     return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
--   end,
--   color = { fg = colors.fg_dark },
-- })

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
  function()
    return "%="
  end,
})

-- Add components to right sections
-- ins_right {
--   'o:encoding', -- option component same as &encoding in viml
--   fmt = string.upper, -- I'm not sure why it's upper case either ;)
--   cond = conditions.hide_in_width,
--   color = { fg = colors.green, gui = 'bold' },
-- }

-- ins_right {
--   'fileformat',
--   fmt = string.upper,
--   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--   color = { fg = colors.green, gui = 'bold' },
-- }

-- Tmux indicator
ins_right({
  function()
    local function get_tmux_char()
      local result = io.popen("tmux list-panes -F '#F' | grep Z")
      if result ~= nil and result:read("*a") ~= "" then
        return "██"
      else
        return "■"
      end
    end

    if os.getenv("TMUX") ~= nil then
      return get_tmux_char()
    else
      return ""
    end
  end,
  color = { fg = colors.green }, -- Sets highlighting of component
  padding = { right = 1 }, -- We don't need space before this
})

ins_right({
  "filetype",
})

ins_right({
  "searchcount",
  color = { fg = colors.fg_dark },
})

ins_right({
  "selectioncount",
  color = { fg = colors.bg_dark, bg = colors.blue },
})

ins_right({
  "location",
  color = { fg = colors.fg_dark },
  cond = conditions.buffer_not_empty,
})

ins_right({
  "progress",
  color = { fg = colors.fg_dark },
  cond = conditions.buffer_not_empty,
})

ins_right({
  "diff",
  -- Is it me or the symbol for modified us really weird
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  -- color = { bg = colors.bg_highlight },
  cond = conditions.hide_in_width,
})

ins_right({
  "branch",
  icon = "",
  color = { fg = colors.bg, bg = colors.fg, gui = "bold" },
  fmt = function(branch_name)
    local maxlen = 20
    if vim.api.nvim_strwidth(branch_name) >= maxlen then
      local trimmed = string.sub(branch_name, 1, maxlen)
      local pattern = "[-_]$"
      return string.gsub(trimmed, pattern, "") .. ".."
    end
    return branch_name
  end,
})

-- ins_right {
--   function()
--     return '▊'
--   end,
--   color = { fg = colors.blue },
--   padding = { left = 1 },
-- }

-- Now don't forget to initialize lualine
lualine.setup(config)
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = config,
  },
}
