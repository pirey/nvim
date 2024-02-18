return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      -- keys[#keys + 1] = { "<c-k>", vim.lsp.buf.hover }
      keys[#keys + 1] = { "<leader>k", vim.lsp.buf.hover }
    end,
    opts = {
      servers = {
        tailwindcss = {
          filetypes_include = { "blade" },
          root_dir = require("lspconfig.util").root_pattern("tailwind.config.js"),
        },
        tsserver = {
          root_dir = require("lspconfig.util").find_git_ancestor,
        },
      },
    },
  },
}
