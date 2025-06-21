local M = {}

---@class ProjectPathOpts
---@field set_keymap? boolean Set keymap for :find (default: true)

---Get directories from file list
---@param lines string[]
---@return string[]
local function extract_dirs(lines)
  local cwd = vim.fn.getcwd()
  local seen = {}
  local dirs = {}

  for _, file in ipairs(lines) do
    local dir = vim.fn.fnamemodify(file, ":h")
    if dir ~= "." and not seen[dir] then
      seen[dir] = true
      table.insert(dirs, cwd .. "/" .. dir)
    end
  end

  return dirs
end

---Run a shell command and return output lines
---@param cmd string
---@return string[]
local function run_cmd(cmd)
  local handle = io.popen(cmd)
  if not handle then return {} end

  local result = {}
  for line in handle:lines() do
    table.insert(result, line)
  end
  handle:close()
  return result
end

---Get unignored project directories using fd or git
---@return string[]
local function get_project_dirs()
  if vim.fn.executable("fd") == 1 then
    return extract_dirs(run_cmd("fd -t f"))
  elseif vim.fn.isdirectory(".git") == 1 then
    return extract_dirs(run_cmd("git ls-files --cached --others --exclude-standard"))
  else
    return { "**" }
  end
end

---Set 'path' dynamically based on project
function M.set_project_path()
  local scanpath = get_project_dirs()
  vim.opt.path = vim.list_extend(vim.opt.path:get(), scanpath)
end

---Initialize the plugin
---@param opts? ProjectPathOpts
function M.setup(opts)
  opts = vim.tbl_extend("force", { set_keymap = true }, opts or {})

  M.set_project_path()

  if opts.set_keymap then
    vim.keymap.set("n", "<leader>f", ":find ", { desc = "Find file (uses dynamic 'path')" })
  end
end

return M

