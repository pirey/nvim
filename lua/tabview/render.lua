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
    local name = storage.get_name(tab) or ("Tab " .. i)
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