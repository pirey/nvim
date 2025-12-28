-- WinPicker plugin loader
require('winpicker').setup({
  border = 'none',
  padding = { x = 3, y = 1 },
})
vim.keymap.set('n', '<c-w>p', require('winpicker').pick, { desc = 'Pick window' })
vim.keymap.set('n', '<c-w><c-p>', require('winpicker').pick, { desc = 'Pick window' })
