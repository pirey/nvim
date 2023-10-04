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
      autoformat = false,
      -- setup = {
      --   tsserver = function(_, opts)
      --     local util = require("lspconfig.util")
      --
      --     require("lazyvim.util").on_attach(function(client, buffer)
      --       if client.name == "tsserver" then
      --         -- stylua: ignore
      --         vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", { buffer = buffer, desc = "Organize Imports" })
      --         -- stylua: ignore
      --         vim.keymap.set("n", "<leader>cR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
      --       end
      --     end)
      --
      --     opts.server = {
      --       root_dir = function(fname)
      --         return util.root_pattern(".git")(fname)
      --       end,
      --     }
      --
      --     -- if using lspconfig, don't wrap it under server
      --     -- require("lspconfig").tsserver.setup({
      --     -- root_dir = ...
      --     -- })
      --
      --     require("typescript").setup(opts)
      --     return true
      --   end,
      -- },
      -- servers = {
      --   dartls = {
      --     cmd = { "dart", "language-server", "--protocol=lsp" },
      --   },
      -- },
    },
  },
}
