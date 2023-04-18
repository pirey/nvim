-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.fn.has("wsl") then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enable = 0,
  }
end


if vim.fn.has("nvim") and vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

if vim.fn.has("gui_running") == 1 then
  vim.g.GuiWindowFullScreen = 1
  vim.g.GuiFont = "JetBrainsMono NF:10"
  -- vim.api.nvim_win_set_option(0, "guifont", "JetBrainsMono Nerd Font Mono:10")
  -- vim.o.guifont = "JetBrainsMono NF:10"
end

if vim.fn.has("win64") or vim.fn.has("win32") then
  vim.o.shell = "powershell.exe"
end

vim.o.clipboard = "" -- separate system clipboard and vim clipboard
vim.o.splitright = true
vim.cmd("set formatoptions-=cro") -- disable auto comment, usefull when pasting code snippet that has comments
