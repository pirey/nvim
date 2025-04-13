local M = {}
M.borderchars = {
  top_left = "┏",
  top_right = "┓",
  bottom_left = "┗",
  bottom_right = "┛",
  horizontal = "━",
  vertical = "┃",
}

M.telescope_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
-- M.telescope_borderchars = {
--   M.borderchars.horizontal,
--   M.borderchars.vertical,
--   M.borderchars.horizontal,
--   M.borderchars.vertical,
--   M.borderchars.top_left,
--   M.borderchars.top_right,
--   M.borderchars.bottom_right,
--   M.borderchars.bottom_left,
-- }

return M
