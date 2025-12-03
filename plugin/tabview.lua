-- tabview: Custom tabline plugin
-- Set up the tabline
vim.opt.tabline = '%!v:lua.require("tabview").render()'