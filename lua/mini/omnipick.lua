local M = {}

---@class OmniPickOpts
---@field hl_groups? { added: string, modified: string }
---@field additional_items? string[]
---@field show_dir? boolean
---@field command? string[]
---@field source_name? string
---@field show_icons? boolean
local defaults = {
  hl_groups = { added = "OkMsg", modified = "WarningMsg" },
  additional_items = { ".env", ".envrc" },
  show_dir = true,
  command = nil,
  source_name = "Omni",
  show_icons = true,
}

---@param opts? OmniPickOpts
M.setup = function(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})
  local has_pick, mini_pick = pcall(require, "mini.pick")
  if not has_pick then
    error(string.format([['mini.omni' requires 'mini.pick' which can not be found.]]))
  end

  local has_visits, mini_visits = pcall(require, "mini.visits")

  mini_pick.registry.omni = function()
    -- credits to https://www.reddit.com/r/neovim/comments/1d9d4uo/my_combined_files_directories_and_recents_picker/
    -- modified to add git status highlights

    local ns_id = vim.api.nvim_create_namespace("mini_pick_git_status")

    -- remove cwd prefix from visited paths
    local short_path = function(path)
      local cwd = vim.fn.getcwd()
      local abs_path = vim.fn.fnamemodify(path, ":p")
      if vim.startswith(abs_path, cwd) then
        return abs_path:sub(cwd:len() + 1):gsub("^/+", "")
      else
        return vim.fn.fnamemodify(abs_path, ":~")
      end
    end

    -- merge multiple arrays, deduplicating across all
    local merge = function(...)
      local result = {}
      local seen = {}
      for _, arr in ipairs({ ... }) do
        for _, item in ipairs(arr) do
          if not seen[item] then
            table.insert(result, item)
            seen[item] = true
          end
        end
      end
      return result
    end

    local is_not_cwd = function(path_data)
      local cwd = vim.fn.getcwd()
      return path_data.path ~= cwd
    end
    local is_within_cwd = function(path_data)
      local cwd = vim.fn.getcwd()
      return path_data.path:sub(1, #cwd) == cwd
    end
    local is_not_git = function(path_data)
      local cwd = vim.fn.getcwd()
      return not vim.startswith(path_data.path, cwd .. "/.git")
    end
    local recents = {}
    if has_visits then
      local filter_recents = function(path_data)
        return is_not_cwd(path_data) and is_within_cwd(path_data) and is_not_git(path_data)
      end
      recents = mini_visits.list_paths(vim.fn.getcwd(), { filter = filter_recents })
    end

    -- these are usually filtered out by gitignore but I want them in the results
    local additional_items = vim.fs.find(opts.additional_items, { path = vim.fn.getcwd() })

    -- git changes (added, modified, renamed files, excluding deleted)
    local git_changes = {}
    local git_status_map = {}
    local git_output = vim.fn.systemlist("git status --porcelain 2>/dev/null")
    for _, line in ipairs(git_output) do
      local status = line:sub(1, 2)
      local file = line:sub(4)
      if status:match("R") then
        local _, new = file:match("(.+) -> (.+)")
        if new then
          file = new
        end
      end
      if (status:match("[AMR?]") or status == "??") and not status:match("D") then
        local short = short_path(file)
        git_status_map[short] = status
        table.insert(git_changes, short)
      end
    end

    -- opened buffers (only within cwd and listed in :ls)
    local buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local bufname = vim.api.nvim_buf_get_name(buf)
      local buflisted = vim.api.nvim_get_option_value("buflisted", { buf = buf })
      if
        buflisted
        and vim.api.nvim_buf_is_loaded(buf)
        and bufname ~= ""
        and vim.startswith(bufname, vim.fn.getcwd())
      then
        table.insert(buffers, bufname)
      end
    end

    local command = opts.command
      or (function()
        local cmd = { "fd", "--hidden", "--type", "f", "--exclude", ".git" }
        if opts.show_dir then
          table.insert(cmd, "--type")
          table.insert(cmd, "d")
        end
        return cmd
      end)()

    mini_pick.builtin.cli({
      -- find files and directories with fd
      command = command,
      -- probably not intended for it but I use the postprocess callback to
      -- combine fd results with recents from mini.visits
      postprocess = function(items)
        local shortened_additional = vim.tbl_map(short_path, additional_items)
        local shortened_recents = vim.tbl_map(short_path, recents)
        local shortened_buffers = vim.tbl_map(short_path, buffers)
        return merge(git_changes, shortened_buffers, shortened_recents, items, shortened_additional)
      end,
    }, {
      source = {
        name = opts.source_name,
        show = function(buf_id, items, query)
          mini_pick.default_show(buf_id, items, query, { show_icons = opts.show_icons })
          -- clear previous git status highlights
          vim.api.nvim_buf_clear_namespace(buf_id, ns_id, 0, -1)
          -- add status highlights for git changes
          for i, item in ipairs(items) do
            local status = git_status_map[item]
            if status then
              local hl_group
              if status:match("A") or status:match("?") then
                hl_group = opts.hl_groups.added
              elseif status:match("[MR]") then
                hl_group = opts.hl_groups.modified
              end
              if hl_group then
                local last_slash = item:find("/[^/]*$")
                local start_col = last_slash and (last_slash + 1) or 1
                vim.hl.range(buf_id, ns_id, hl_group, { i - 1, start_col - 1 }, { i - 1, -1 }, { priority = 300 })
              end
            end
          end
        end,
        choose = vim.schedule_wrap(mini_pick.default_choose),
      },
    })
  end
end

return M
