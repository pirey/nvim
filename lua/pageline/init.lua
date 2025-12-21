local M = {}

-- Load submodules
local storage = require("pageline.storage")
local render = require("pageline.render")

-- Setup function
function M.setup(opts)
  opts = opts or {}
  storage.setup(opts)
  render.setup(opts)
  vim.opt.tabline = '%!v:lua.require("pageline").render()'
end

-- Render the tabline
function M.render()
  return render.render()
end

-- Commands
vim.api.nvim_create_user_command("TabRename", function(args)
  storage.set_name(vim.api.nvim_get_current_tabpage(), args.args)
  vim.cmd("redrawtabline")
end, { nargs = 1 })

vim.api.nvim_create_user_command("TabClear", function()
  storage.clear_name(vim.api.nvim_get_current_tabpage())
  vim.cmd("redrawtabline")
end, {})

vim.api.nvim_create_user_command("TabToggle", function()
  if vim.o.tabline == "" then
    vim.opt.tabline = '%!v:lua.require("pageline").render()'
  else
    vim.opt.tabline = ""
  end
end, {})

return M
