-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- terminal
local function is_lazygit_term(bufname)
  local pattern = "lazygit"
  return string.match(bufname, pattern)
end

function _G.handle_term_open()
  if is_lazygit_term(vim.fn.bufname()) then
    return
  end

  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
end

vim.cmd("autocmd! TermOpen term://* lua handle_term_open()")
