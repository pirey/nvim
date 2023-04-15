-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

vim.keymap.set({ "n", "v" }, ";", ":")

-- movements
vim.keymap.set({ "n", "v" }, "E", "20l")
vim.keymap.set({ "n", "v" }, "B", "20h")
vim.keymap.set({ "n", "v" }, "J", "15gj")
vim.keymap.set({ "n", "v" }, "K", "15gk")

-- clipboard / copy paste
vim.keymap.set("v", "<c-c>", '"*y')
vim.keymap.set("n", "gp", "`[v`]", { desc = "Select last pasted text" })
vim.keymap.set("n", "yp", "yyp")
vim.keymap.set("n", "yP", "yyP")

-- window
vim.keymap.set("n", "<Up>", "5<c-w>+", { silent = true })
vim.keymap.set("n", "<Right>", "5<c-w>>", { silent = true })
vim.keymap.set("n", "<Down>", "5<c-w>-", { silent = true })
vim.keymap.set("n", "<Left>", "5<c-w><", { silent = true })

vim.keymap.set("v", "$", "$h")

vim.keymap.del("n", "<leader>gG")
vim.keymap.set("n", "<leader>gg", function()
  Util.float_term({ "lazygit" }, {
    size = {
      width = 1,
      height = 1,
    },
  })
end, { desc = "Lazygit" })
