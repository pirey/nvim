local Util = require("lazyvim.util")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local transform_mod = require("telescope.actions.mt").transform_mod

local custom_actions = transform_mod({
  open_and_resume = function(prompt_bufnr)
    actions.select_default(prompt_bufnr)
    require("telescope.builtin").resume()
  end,
})

local function normalize_path(path)
  return path:gsub('\\', '/')
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. '/'
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

--@param path string
--@return string, string
local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match('[^/]+$')
  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    return normalized_path, filename
  end
end

local function path_display(_, path)
  local without_cwd, fname = split_filepath(path)
  return string.format("%s (%s)", fname, without_cwd)
end

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
        path_display = path_display,
        mappings = {
          i = {
            ["<c-c>"] = false,
            ["<esc>"] = actions.close,
            ["<c-t>"] = trouble.smart_open_with_trouble,
            ["<Right>"] = custom_actions.open_and_resume,
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
