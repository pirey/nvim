-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- if vim.fn.has("wsl") == 1 then
--   vim.g.clipboard = {
--     name = "WslClipboard",
--     copy = {
--       ["+"] = "clip.exe",
--       ["*"] = "clip.exe",
--     },
--     paste = {
--       ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--       ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
--     },
--     cache_enable = 0,
--   }
-- end

if vim.fn.has("nvim") == 1 and vim.fn.executable("nvr") == 1 then
  vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

if vim.fn.has("gui_running") == 1 then
  vim.g.GuiWindowFullScreen = 1
  vim.g.GuiFont = "JetBrainsMono NF:10"
  -- vim.api.nvim_win_set_option(0, "guifont", "JetBrainsMono Nerd Font Mono:10")
  -- vim.o.guifont = "JetBrainsMono NF:10"
end

if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
  vim.o.shell = "powershell.exe"
  vim.o.laststatus = 3
end

vim.o.splitright = true
vim.o.clipboard = "" -- separate system clipboard and vim clipboard
vim.opt.formatoptions:remove({ "c", "r", "o" })
vim.opt.signcolumn = "yes"
vim.opt.number = false
vim.opt.relativenumber = false
vim.o.wrap = false
vim.opt.listchars = { space = "·", tab = "▸ " }

-- clean diff
vim.opt.fillchars:append({ diff = " " })

-- fold
vim.o.foldenable = true
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99

-- search & replace
vim.o.gdefault = true

-- terminal
vim.o.scrollback = 10000
if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
  local powershell_options = {
    shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
    shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
    shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
    shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
    shellquote = "",
    shellxquote = "",
  }

  for option, value in pairs(powershell_options) do
    vim.o[option] = value
  end
end

vim.cmd([[
  command! -nargs=0 CopyRelativePath :let @+=expand('%:p:~:.')
]])
