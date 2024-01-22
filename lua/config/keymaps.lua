-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n" }, "<leader>;", "q:", { desc = "Command line window" })

-- movements/navigation
vim.keymap.set({ "n", "v" }, "E", "20l")
vim.keymap.set({ "n", "v" }, "B", "20h")
vim.keymap.set({ "n", "v" }, "J", "15gj")
vim.keymap.set({ "n", "v" }, "K", "15gk")
-- vim.keymap.set({ "n", "v" }, "zl", "L")
-- vim.keymap.set({ "n", "v" }, "zh", "H")
vim.keymap.set({ "n", "v" }, "zl", "20zl")
vim.keymap.set({ "n", "v" }, "zh", "20zh")
vim.keymap.set({ "n", "v" }, "<c-e>", "<c-b>")
vim.keymap.set("v", "$", "$h")

-- clipboard / copy paste
vim.keymap.set("v", "<c-c>", '"+y')
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })
vim.keymap.set("n", "yp", "yyp")
vim.keymap.set("n", "yP", "yyP")
-- vim.keymap.set("i", "<c-v>", "<c-r>+", { desc = "Paste properly" })
vim.api.nvim_set_keymap("c", "<c-v>", "<c-r>+", { desc = "Paste" })

-- terminal
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.del("t", "<esc><esc>")
vim.keymap.del("t", "<c-h>")
vim.keymap.del("t", "<c-j>")
vim.keymap.del("t", "<c-k>")
vim.keymap.del("t", "<c-l>")
vim.keymap.del("t", "<C-/>")
vim.keymap.del("t", "<c-_>")

vim.keymap.del("n", "<leader>ft")
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<c-/>")
vim.keymap.del("n", "<c-_>")

-- window
vim.keymap.set("n", "<Up>", "5<c-w>+", { silent = true })
vim.keymap.set("n", "<Right>", "5<c-w>>", { silent = true })
vim.keymap.set("n", "<Down>", "5<c-w>-", { silent = true })
vim.keymap.set("n", "<Left>", "5<c-w><", { silent = true })
vim.keymap.set("n", "<leader>wo", "<cmd>wincmd o<cr>", { silent = true, desc = "Close other windows" })
vim.keymap.set("n", "<leader>wj", "<cmd>wincmd j<cr>", { silent = true })
vim.keymap.set("n", "<leader>wk", "<cmd>wincmd k<cr>", { silent = true })
vim.keymap.set("n", "<leader>wh", "<cmd>wincmd h<cr>", { silent = true })
vim.keymap.set("n", "<leader>wl", "<cmd>wincmd l<cr>", { silent = true })
vim.keymap.set("n", "<leader>wJ", "<cmd>wincmd J<cr>", { silent = true })
vim.keymap.set("n", "<leader>wK", "<cmd>wincmd K<cr>", { silent = true })
vim.keymap.set("n", "<leader>wH", "<cmd>wincmd H<cr>", { silent = true })
vim.keymap.set("n", "<leader>wL", "<cmd>wincmd L<cr>", { silent = true })

-- copy paste
-- TODO: copy only matches, not entire line
vim.keymap.set("n", "<leader>sy", [[<cmd>let @a = ''<cr><cmd>g//y A<cr>]], { desc = "copy search matches" })

vim.keymap.set(
  "n",
  "<leader>sY",
  [[<cmd>let @+ = ''<cr><cmd>g//let @+ .= getline('.') . "\n"<cr>]],
  { desc = "copy search matches to clipboard" }
)

-- etc
vim.keymap.del("n", "<leader>gG")
vim.keymap.set("n", "<leader>gg", function()
  Util.float_term({ "lazygit" }, {
    size = {
      width = 1,
      height = 1,
    },
  })
end, { desc = "Lazygit" })
vim.keymap.set("i", "<c-t>", '<c-r>=strftime("%FT%T%z")<cr>')
