return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable keymaps
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gr", false }

      -- add a keymap
      keys[#keys + 1] = { "<c-k>", vim.lsp.buf.hover }
    end,
    opts = {
      autoformat = false,
    },
  },
}
