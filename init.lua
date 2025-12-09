vim.g.mapleader = " "

-- essentials
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

-- fancy
vim.opt.switchbuf = { "uselast", "useopen", "usetab" }
vim.opt.tabclose = "left"
vim.opt.splitright = true
vim.opt.number = true
vim.opt.scrolloff = 3
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
-- vim.opt.tabline = "%=Tabs: %{tabpagenr()}/%{tabpagenr('$')}%="
vim.opt.fillchars:append({ diff = " " })
vim.opt.wildoptions:append({ "fuzzy" })

-- ignore .git by default so we doesn't need to specify it when using --hidden
vim.opt.grepprg = "rg --hidden --vimgrep --smart-case --glob=!.git"

vim.keymap.set({ "n", "v" }, ";", ":", { desc = "Swap ; with :" })
vim.keymap.set({ "n", "v" }, ":", ";", { desc = "Swap : with ;" })
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set("v", "<c-c>", '"+y', { silent = true, desc = "Copy to clipboard" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })
vim.keymap.set("n", "<leader>x", "<cmd>confirm bd<cr>", { silent = true, desc = "Confirm delete buffer" })
vim.keymap.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { silent = true, desc = "Close tab" })
vim.keymap.set("n", "<leader><tab>o", "<cmd>tabonly<cr>", { silent = true, desc = "Close other tabs" })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tabs<cr>", { silent = true, desc = "List tabs" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>", { silent = true, desc = "New tab" })
vim.keymap.set("n", "<leader>tt", "<cmd>bot term<cr>", { silent = true })
vim.keymap.set("n", "<leader>tv", "<cmd>vert term<cr>", { silent = true })
vim.keymap.set("n", "<leader>tv", "<cmd>vert term<cr>", { silent = true })
vim.keymap.set("n", "<leader>t<tab>", "<cmd>tab term<cr>", { silent = true })
vim.keymap.set('t', '<c-\\>', '<c-\\><c-n>', { noremap = true })
-- vim.keymap.set('t', '<c-[>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("n", "]<tab>", "gt", { silent = true })
vim.keymap.set("n", "[<tab>", "gT", { silent = true })
vim.keymap.set("c", "<C-j>", "<Down>", { noremap = true })
vim.keymap.set("c", "<C-k>", "<Up>", { noremap = true })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<cr><cmd>lclose<cr>", { noremap = true })

vim.cmd("autocmd TermOpen * startinsert")
vim.cmd("autocmd QuickFixCmdPost grep,grep! copen")

-- experimental
if vim.fn.has("nvim-0.12") == 1 then
  vim.opt.pumborder = "rounded"
  vim.opt.cmdheight = 0
  require("vim._extui").enable({
    enable = true,
  })
end

require("plugins")
