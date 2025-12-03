local M = {}

local tab_names = {}
local storage_file = vim.fn.stdpath("data") .. "/tabview/names.json"

function M.setup(opts)
  opts = opts or {}
  storage_file = opts.storage_file or storage_file
  M.load()
end

function M.load()
  if vim.fn.filereadable(storage_file) == 1 then
    local content = vim.fn.readfile(storage_file)
    tab_names = vim.fn.json_decode(table.concat(content, "\n")) or {}
  end
end

function M.save()
  vim.fn.mkdir(vim.fn.fnamemodify(storage_file, ":h"), "p")
  local content = vim.fn.json_encode(tab_names)
  vim.fn.writefile({content}, storage_file)
end

function M.get_name(tabpage)
  return tab_names[tostring(tabpage)]
end

function M.set_name(tabpage, name)
  tab_names[tostring(tabpage)] = name
  M.save()
end

function M.clear_name(tabpage)
  tab_names[tostring(tabpage)] = nil
  M.save()
end

-- Cleanup on tab close
vim.api.nvim_create_autocmd("TabClosed", {
  callback = function(args)
    local tabpage = tonumber(args.match)
    if tabpage then
      tab_names[tostring(tabpage)] = nil
      M.save()
    end
  end,
})

return M