-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "n", "v" }, ";", ":")
vim.keymap.set({ "n", "v" }, "E", "20l")
vim.keymap.set({ "n", "v" }, "B", "20h")
vim.keymap.set({ "n", "v" }, "J", "15gj")
vim.keymap.set({ "n", "v" }, "K", "15gk")
