local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  buffer_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
  end,
  hide_in_width = function(w)
    return function()
      return vim.fn.winwidth(0) > w
    end
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
local branch = {
  "branch",
  icon = "",
}

-- TODO: adjust color for diff and diagnostics (and filetype)
local diff = {
  "diff",
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { error = " ", warn = " ", info = " " },
  -- symbols = { error = "E", warn = "W", info = "I", hint = "H" },
}

local filename = {
  "filename",
  path = 1,
  shorting_target = vim.fn.winwidth(0) / 1.2,
  symbols = {
    modified = "●",
  },
  cond = conditions.buffer_not_empty,
}

local separator = {
  "%=",
}

local space = {
  function()
    return " "
  end,
}

local macro = {
  function()
    local char_register = vim.fn.reg_recording()
    if #char_register > 0 then
      return "REC @" .. char_register
    end
    return ""
  end,
  color = "Visual",
}

local searchcount = {
  "searchcount",
  color = "Search",
}

local selectioncount = {
  "selectioncount",
  color = "Visual",
}

local location = {
  "location",
  cond = conditions.buffer_not_empty,
}

local max_line = {
  function()
    return vim.fn.line("$")
  end,
  cond = conditions.buffer_not_empty,
}

local encoding = {
  "encoding",
}

local filetype = {
  "%y",
  -- "filetype",
  -- colored = false,
}

local progress = {
  "progress",
  cond = conditions.buffer_not_empty,
}

local tmux_char = {
  function()
    local result = io.popen("tmux list-panes -F '#F' | grep Z")

    if result ~= nil and result:read("*a") ~= "" then
      result:close()
      return "■"
    else
      return ""
    end
  end,
  padding = { left = 1, right = 1 }, -- We don't need space before this
  cond = function()
    return os.getenv("TMUX") ~= nil
  end,
  on_click = function()
    os.execute("tmux resize-pane -Z")
  end,
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = {
        normal = {
          a = "StatusLine",
          b = "StatusLine",
          c = "StatusLine",
          x = "StatusLine",
          y = "StatusLine",
          z = "StatusLine",
        },
      },
      global_status = true,
      always_divide_middle = false,
      -- Disable sections and component separators
      component_separators = "", -- "│",
      section_separators = "", -- "│",
      disabled_filetypes = {
        statusline = { "neo-tree", "git", "fugitive", "toggleterm" },
        winbar = { "neo-tree", "DiffviewFiles", "git" },
      },
    },
    sections = {
      lualine_a = {
        branch,
      },
      lualine_b = {},
      lualine_c = {
        filename,
      },
      lualine_x = {
        diff,
        diagnostics,
        macro,
        searchcount,
        selectioncount,
      },
      lualine_y = {
        location,
        max_line,
      },
      lualine_z = {
        encoding,
        filetype,
        progress,
        tmux_char,
      },
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
  },
}
