-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup("PireyAugroup", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  pattern = "term://*",
  callback = function()
    local function is_lazygit_term(bufname)
      local pattern = "lazygit"
      return string.match(bufname, pattern)
    end

    if is_lazygit_term(vim.fn.bufname()) then
      return
    end

    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client ~= nil then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})
