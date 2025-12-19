local M = {}

local storage = require("tabview.storage")

function M.setup(opts)
  M.options = vim.tbl_extend("force", {
    ft_titles = {}
  }, opts or {})
end

function M.render()
  if not M.options then
    M.options = { ft_titles = {} }
  end
  local tabs = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local tabline = ""

  for i, tab in ipairs(tabs) do
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local normal_win_count = 0
    local detected_title
    for _, win in ipairs(wins) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative == "" then
        normal_win_count = normal_win_count + 1
        if not detected_title then
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
          if ft and ft ~= "" and M.options.ft_titles[ft] then
            detected_title = M.options.ft_titles[ft]
          end
        end
      end
    end
    local char = "●"
    local char_title = " " .. string.rep(char, math.max(1, normal_win_count))
    local name = detected_title or storage.get_name(tab) or char_title
    local is_current = tab == current_tab

    -- Highlight group
    local hl = is_current and "%#TabLineSel#" or "%#TabLine#"

    -- Tab label
    local label = string.format(" %d:%s ", i, name)

    -- Click to switch tab
    local click = "%" .. i .. "T"

    tabline = tabline .. hl .. click .. label .. "%T"
  end

  -- Fill the rest
  tabline = tabline .. "%#TabLineFill#%T"

  return tabline
end

return M
