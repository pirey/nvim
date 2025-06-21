vim.g.mapleader = " "

-- essentials
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.number = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- fancy
vim.opt.winborder = "single"
vim.opt.fillchars:append { diff = " " }
vim.opt.tabline = "%=%{tabpagenr()}/%{tabpagenr('$')}%="

vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Swap ; with :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Swap : with ;" })
vim.keymap.set("v", "<c-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { silent = true, desc = "Close tab" })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { silent = true, desc = "Close other tabs" })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tabs<cr>", { silent = true, desc = "List tabs" })
vim.keymap.set("n", "<leader>.", ":find ")

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("colorscheme iceberg")

require("plugins")
require("autopath").setup({
  set_keymap = false,
})
