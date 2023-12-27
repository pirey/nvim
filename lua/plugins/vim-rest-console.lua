return {
  "diepm/vim-rest-console",
  init = function()
    os.execute("mkdir -p ~/.vim-rest-console")
    vim.api.nvim_create_user_command("VRC", function(arg)
      local filename = arg.args
      if #filename == 0 then
        filename = "index"
      end
      vim.cmd("edit ~/.vim-rest-console/" .. filename .. ".rest")
    end, { nargs = "?", desc = "Open http client" })
  end,
}
