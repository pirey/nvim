if vim.fn.executable("cabal-gild") == 1 then
  vim.api.nvim_create_user_command("CabalFormat", function()
    vim.cmd("silent w | silent !cabal-gild -i % -o %")
  end, {})
end

