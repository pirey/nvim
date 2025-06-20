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
vim.opt.winborder = "single"
vim.opt.showtabline = 0

vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"

vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, ":", ";")
vim.keymap.set("v", "<c-c>", '"+y')
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { silent = true, desc = "Close tab" })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { silent = true, desc = "Close other tabs" })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tabs<cr>", { silent = true, desc = "List tabs" })

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("colorscheme iceberg")

require('plugins')
