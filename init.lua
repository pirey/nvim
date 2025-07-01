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
vim.opt.winborder = "single"
vim.opt.fillchars:append { diff = " " }
vim.opt.tabline = "%=Tabs: %{tabpagenr()}/%{tabpagenr('$')}%="

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

vim.cmd([[
  cabbrev <expr> gc getcmdtype() == ':' && getcmdline() =~# '^gc' ? '!git commit -m' : 'gc'
  cabbrev <expr> gad getcmdtype() == ':' && getcmdline() =~# '^gad' ? '!git add %' : 'gad'
  cabbrev <expr> gst getcmdtype() == ':' && getcmdline() =~# '^gst' ? '!git status' : 'gst'
  cabbrev <expr> gco getcmdtype() == ':' && getcmdline() =~# '^gco' ? '!git checkout -b' : 'gco'
  cabbrev <expr> gcn getcmdtype() == ':' && getcmdline() =~# '^gcn' ? '!git commit --amend --no-edit' : 'gcn'
  cabbrev <expr> git getcmdtype() == ':' && getcmdline() =~# '^git' ? '!git' : 'git'
]])

vim.cmd("autocmd TermOpen * startinsert")
-- vim.cmd("colorscheme iceberg")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
  callback = function()
    if vim.bo.modified then
      vim.cmd("hi! link StatusLine StatusLineNC")
    else
      vim.cmd("hi! link StatusLine StatusLine")  -- or your preferred default
    end
  end,
})

require("plugins")
