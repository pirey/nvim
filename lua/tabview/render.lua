local M = {}

local storage = require("tabview.storage")

function M.setup()
  -- Setup options if needed
end

function M.render()
  local tabs = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local tabline = ""

  for i, tab in ipairs(tabs) do
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local normal_win_count = 0
    for _, win in ipairs(wins) do
      if vim.api.nvim_win_get_config(win).relative == "" then
        normal_win_count = normal_win_count + 1
      end
    end
    local name = storage.get_name(tab) or string.rep("•", normal_win_count)
    local is_current = tab == current_tab

    -- Highlight group
    local hl = is_current and "%#TabLineSel#" or "%#TabLine#"

    -- Tab label
    local label = string.format(" %d: %s ", i, name)

    -- Click to switch tab
    local click = "%" .. i .. "T"

    tabline = tabline .. hl .. click .. label .. "%T"
  end

  -- Fill the rest
  tabline = tabline .. "%#TabLineFill#%T"

  return tabline
end

return M