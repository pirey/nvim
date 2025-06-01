vim.g.mapleader = " "

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, ":", ";")
vim.keymap.set("n", "<leader>.", ":set path+=**<left><left>")
vim.keymap.set("v", "<c-c>", '"+y')
vim.keymap.set("n", "<esc>", ":noh<cr>:<c-c>", { desc = "Clear search highlight", silent = true })

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("colorscheme iceberg")

-- vim.opt.termguicolors = false
-- vim.cmd("colorscheme vim")
