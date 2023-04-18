local Util = require("lazyvim.util")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local transform_mod = require("telescope.actions.mt").transform_mod

-- borrowed from telescope.utils.path_tail
local function path_tail(path, sep)
  for i = #path, 1, -1 do
    if path:sub(i, i) == sep then
      return path:sub(i + 1, -1)
    end
  end
  return path
end

-- the results for find_files and oldfiles have different file separator
-- need to check for both separator to properly get the filename
local function get_filename_from_path(path)
  local unix_sep = "/"
  local windows_sep = "\\"
  local tail = path_tail(path, unix_sep)
  if tail == path then
    return path_tail(path, windows_sep)
  end
  return tail
end

local custom_actions = transform_mod({
  open_and_resume = function(prompt_bufnr)
    actions.select_default(prompt_bufnr)
    require("telescope.builtin").resume()
  end
})

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- git
      { "<leader>gs", false },
      { "<leader>gc", false },
      { "<leader>gS", "<cmd>Telescope git_status<cr>", desc = "Git status with preview" },

      -- find
      { "<leader><space>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>ff", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fF", Util.telescope("files"), desc = "Find Files (root dir)" },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        -- path_display = { "truncate" },
        path_display = function(_, path)
          local tail = get_filename_from_path(path)
          return string.format("%s (%s)", tail, path)
        end,
        mappings = {
          i = {
            ["<c-c>"] = false,
            ["<esc>"] = actions.close,
            ["<c-t>"] = trouble.smart_open_with_trouble,
            ["<c-l>"] = custom_actions.open_and_resume,
          },
        },
      },
      pickers = {
        lsp_references = {
          fname_width = 100,
          show_line = false,
          trim_text = true,
        },
      },
    },
  },
}
