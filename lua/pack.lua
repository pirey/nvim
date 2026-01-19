---@class SpecExt : vim.pack.Spec
---@field config function
---@field dependencies vim.pack.Spec[]

---@param src string
---@return string
local function normalize_src(src)
  if src:match("^[a-z]+://") then
    return src
  end
  return "https://github.com/" .. src:gsub("^/", "")
end

local M = {}

function M.list()
  vim.pack.update()
end

function M.update()
  local specs = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()
  vim.pack.update(specs, { force = true })
end

function M.clean()
  local specs = vim
    .iter(vim.pack.get())
    :filter(function(x)
      return not x.active
    end)
    :map(function(x)
      return x.spec.name
    end)
    :totable()
  vim.pack.del(specs, { force = true })
end

---@param specs_ext SpecExt[]
function M.setup(specs_ext)
  local specs = {}
  local configs = {}

  -- resolve specs and configs
  for _, spec in ipairs(specs_ext) do
    if spec.dependencies then
      for _, dep in ipairs(spec.dependencies) do
        table.insert(specs, { src = normalize_src(dep.src), version = dep.version })
      end
    end
    table.insert(specs, vim.tbl_extend("force", spec, { src = normalize_src(spec.src) }))
    if spec.config then
      table.insert(configs, spec.config)
    end
  end

  -- install packages
  vim.pack.add(specs)

  -- configure packages
  for _, config in ipairs(configs) do
    config()
  end

  -- create user commands
  vim.api.nvim_create_user_command("PackUpdate", M.update, { desc = "Update all packages" })
  vim.api.nvim_create_user_command("PackClean", M.clean, { desc = "Clean all packages" })
  vim.api.nvim_create_user_command("PackList", M.list, { desc = "List all packages" })
end

return M
