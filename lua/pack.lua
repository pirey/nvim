---@class SpecExt : vim.pack.Spec
---@field config function
---@field dependencies vim.pack.Spec[]

---@param src string
---@return string
local function normalize_src(src)
  if src:match("^https?://") or src:match("^//") then
    return src
  end
  return "https://github.com/" .. src:gsub("^/", "")
end

local M = {}

function M.list()
  vim.pack.update(nil, { offline = true })
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
  local specs = vim.iter(vim.pack.get()):filter(function(x) return not x.active end):map(function(x) return x.spec.name end):totable()
  vim.pack.del(specs, { force = true })
end

---@param specs_ext SpecExt[]
function M.setup(specs_ext)
  local specs = {}
  local configs = {}

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

  vim.pack.add(specs)

  for _, config in ipairs(configs) do
    config()
  end
end

return M
