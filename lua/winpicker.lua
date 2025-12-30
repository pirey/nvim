-- WinPicker module: Pick window to focus by letter

local M = {}

---@class WinPickerOpts
---@field position? string
---@field cancel_key? string
---@field letters? string[]
---@field skip_buftypes? string[]
---@field skip_filetypes? string[]
---@field border? string
---@field padding? { x: number, y: number }

-- Default options
---@type WinPickerOpts
local defaults = {
  position = 'center', -- 'center', 'topleft', 'topright', 'bottomleft', 'bottomright', 'topcenter', 'bottomcenter'
  cancel_key = '<esc>', -- cancel key
  letters = { 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l' },
  skip_buftypes = {}, -- buftypes to skip
  skip_filetypes = {'opencode_footer'}, -- filetypes to skip
  border = 'auto', -- 'auto' uses vim.o.winborder, or custom style
  padding = { x = 2, y = 0 }, -- text padding (x: horizontal, y: vertical)
}

-- Function to show letter in a window
---@param win number
---@param letter string
---@return number float_win
local function show_letter(win, letter)
  -- Create a floating window with the letter
  local buf = vim.api.nvim_create_buf(false, true)
  local line = string.rep(" ", M.opts.padding.x) .. string.upper(letter) .. string.rep(" ", M.opts.padding.x)
  local lines = {}
  for _ = 1, M.opts.padding.y do
    table.insert(lines, "")
  end
  table.insert(lines, line)
  for _ = 1, M.opts.padding.y do
    table.insert(lines, "")
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Get window size
  local win_height = vim.api.nvim_win_get_height(win)
  local win_width = vim.api.nvim_win_get_width(win)
  local width = 2 * M.opts.padding.x + 1
  local height = 2 * M.opts.padding.y + 1
  local row, col
  if M.opts.position == 'center' then
    row = math.floor((win_height - height) / 2)
    col = math.floor((win_width - width) / 2)
  elseif M.opts.position == 'topleft' then
    row = 1
    col = 1
  elseif M.opts.position == 'topright' then
    row = 1
    col = win_width - width
  elseif M.opts.position == 'bottomleft' then
    row = win_height - height
    col = 1
  elseif M.opts.position == 'bottomright' then
    row = win_height - height
    col = win_width - width
  elseif M.opts.position == 'topcenter' then
    row = 1
    col = math.floor((win_width - width) / 2)
  elseif M.opts.position == 'bottomcenter' then
    row = win_height - height
    col = math.floor((win_width - width) / 2)
  else
    -- default to center
    row = math.floor((win_height - height) / 2)
    col = math.floor((win_width - width) / 2)
  end

  local border = M.opts.border == 'auto' and (vim.o.winborder ~= '' and vim.o.winborder or 'none') or M.opts.border

  local float_win = vim.api.nvim_open_win(buf, false, {
    relative = 'win',
    win = win,
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = border,
  })
  vim.api.nvim_set_option_value('winhl', 'Normal:WinPickerLabel,FloatBorder:WinPickerLabelBorder', { win = float_win })
  return float_win
end

-- Function to pick window
function M.pick()
  if not M.opts then M.setup() end
  -- Set inverse Normal highlight for labels if not overridden
  local existing = vim.api.nvim_get_hl(0, { name = 'WinPickerLabel' })
  if not existing.fg then
    local normal_hl = vim.api.nvim_get_hl(0, { name = 'Normal' })
    local fg = normal_hl.fg
    local bg = normal_hl.bg
    vim.api.nvim_set_hl(0, 'WinPickerLabel', { fg = bg, bg = fg, bold = true })
  end
  -- Set border highlight to FloatBorder
  vim.api.nvim_set_hl(0, 'WinPickerLabelBorder', { link = 'FloatBorder' })

  vim.api.nvim_echo({{"-- Choose a window --", "ModeMsg"}}, false, {})
  local tabpage = vim.api.nvim_get_current_tabpage()
  local wins = vim.api.nvim_tabpage_list_wins(tabpage)
  -- Filter windows (only normal windows with valid buffers)
  local filtered_wins = {}
  for _, win in ipairs(wins) do
    if vim.api.nvim_win_get_config(win).relative == '' then
      local buf = vim.api.nvim_win_get_buf(win)
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = buf })
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = buf })
      if not vim.tbl_contains(M.opts.skip_buftypes, buftype) and not vim.tbl_contains(M.opts.skip_filetypes, filetype) then
        table.insert(filtered_wins, win)
      end
    end
  end
  if #filtered_wins <= 1 then
    vim.api.nvim_echo({}, false, {}) -- clear message
    return
  end

  local win_map = {}

   -- Extend letters if more windows than letters
   local extended_letters = vim.deepcopy(M.opts.letters)
   local all_letters = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' }
   for _, let in ipairs(all_letters) do
     if not vim.tbl_contains(extended_letters, let) then
       table.insert(extended_letters, let)
       if #extended_letters >= #filtered_wins then break end
     end
   end

  -- Assign letters and show them with floating windows
  for i, win in ipairs(filtered_wins) do
    local letter = extended_letters[i]
    if not letter then break end
    local float_win = show_letter(win, letter)
    win_map[letter] = { main_win = win, buf = vim.api.nvim_win_get_buf(win), float_win = float_win }
  end

  -- Get user input
  vim.cmd('redraw')
  local ok, input = pcall(vim.fn.getcharstr)
  if not ok then
    -- Interrupted, cancel
    for _, data in pairs(win_map) do
      if data.float_win then
        vim.api.nvim_win_close(data.float_win, true)
      end
    end
    vim.api.nvim_echo({}, false, {}) -- clear message
    return
  end
  local check = M.opts.cancel_key == "<esc>" and "\27" or M.opts.cancel_key
  if input == check then
    -- Close floating windows and cancel
    for _, data in pairs(win_map) do
      if data.float_win then
        vim.api.nvim_win_close(data.float_win, true)
      end
    end
    vim.api.nvim_echo({}, false, {}) -- clear message
    return
  end
  input = string.lower(input)

  -- Close floating windows
  for _, data in pairs(win_map) do
    if data.float_win then
      vim.api.nvim_win_close(data.float_win, true)
    end
  end

  -- Jump to window or set buffer if valid
  local target = win_map[input]
  if target then
    if target.main_win then
      vim.api.nvim_set_current_win(target.main_win)
    else
      vim.api.nvim_set_current_buf(target.buf)
    end
    vim.api.nvim_echo({}, false, {}) -- clear message
  else
    vim.api.nvim_echo({{"No window/buffer for input: " .. input, "ErrorMsg"}}, false, {})
  end
end

-- Setup function
---@param opts WinPickerOpts?
---@return nil
function M.setup(opts)
   M.opts = vim.tbl_extend('force', defaults, opts or {})
end

return M
