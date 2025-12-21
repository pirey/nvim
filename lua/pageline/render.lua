local M = {}

local storage = require("pageline.storage")

function M.setup(opts)
  M.options = vim.tbl_extend("force", {
    ft_titles = {},
    buftype_titles = {},
    char = "■"
  }, opts or {})
end

function M.get_tab_title(tab, normal_win_count)
  -- 1. Detect special buffers: check if any window has a registered filetype or buftype title
  local detected_title
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative == "" then
      if not detected_title then
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
        local bt = vim.api.nvim_get_option_value("buftype", { buf = buf })
        if (ft and ft ~= "" and M.options.ft_titles[ft]) or (bt and bt ~= "" and M.options.buftype_titles[bt]) then
          detected_title = M.options.ft_titles[ft] or M.options.buftype_titles[bt]
        end
      end
    end
  end

  -- 2. Prepare character representation for window count
  local char = M.options.char
  local char_rep = string.rep(char, math.max(1, normal_win_count))

  -- 3. Get focused window title: filename of the current window's buffer
  local focused_win = vim.api.nvim_tabpage_get_win(tab)
  local focused_buf = vim.api.nvim_win_get_buf(focused_win)
  local buf_name = vim.api.nvim_buf_get_name(focused_buf)
  local focused_title = vim.fn.fnamemodify(buf_name, ":t")
  if focused_title == "" then focused_title = nil end

  -- 4. Resolve tab title in priority order:
  --    - Special title (if detected)
  --    - Custom storage name or focused title with window count chars
  --    - Fallback to window count chars only
  local name
  if detected_title then
    name = detected_title
  else
    local temp = storage.get_name(tab) or focused_title
    if temp then
      name = char_rep .. " " .. temp
    else
      name = " " .. char_rep
    end
  end
  return name
end

function M.render()
  if not M.options then
    M.options = { ft_titles = {}, buftype_titles = {}, char = "■" }
  end
  local tabs = vim.api.nvim_list_tabpages()
  local current_tab = vim.api.nvim_get_current_tabpage()
  local tabline = ""

  for i, tab in ipairs(tabs) do
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    local normal_win_count = 0
    for _, win in ipairs(wins) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative == "" then
        normal_win_count = normal_win_count + 1
      end
    end
    local name = M.get_tab_title(tab, normal_win_count)
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
