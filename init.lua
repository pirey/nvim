vim.g.mapleader = " "

-- essentials
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- fancy
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.winborder = "single"
vim.opt.fillchars:append { diff = " " }
vim.opt.tabline = "%#TabLineSel#%=Tabs: %{tabpagenr()}/%{tabpagenr('$')}%="

-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.opt.grepprg = "rg --vimgrep --smart-case --glob '!.git'"

vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Swap ; with :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Swap : with ;" })
vim.keymap.set("v", "<c-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { silent = true, desc = "Close tab" })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { silent = true, desc = "Close other tabs" })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tabs<cr>", { silent = true, desc = "List tabs" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>", { silent = true, desc = "New tab" })

vim.cmd("autocmd TermOpen * startinsert")

require("plugins")
