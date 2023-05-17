local Util = require("lazyvim.util")
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local trouble = require("trouble.providers.telescope")
local transform_mod = require("telescope.actions.mt").transform_mod

local custom_actions = transform_mod({
  open_and_resume = function(prompt_bufnr)
    actions.select_default(prompt_bufnr)
    require("telescope.builtin").resume()
  end,
})

local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. "/"
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

--@param path string
--@return string, string
local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match("[^/]+$")

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

local function path_display(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == "" then
    return filename
  end
  return string.format("%s ~ %s", filename, stripped_path)
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzy-native.nvim",
      config = function()
        require("telescope").load_extension("fzy_native")
      end,
    },
    keys = {
      -- git
      { "<leader>gs", false },
      { "<leader>gc", false },

      -- files
      { "<leader><space>", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>ff", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fF", Util.telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fr", Util.telescope("oldfiles", { cwd_only = true }), desc = "Recent project files" },
      { "<leader>fR", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        -- path_display = { "truncate" },
        path_display = path_display,
        preview = {
          hide_on_startup = true,
        },
        mappings = {
          i = {
            ["<c-c>"] = false,
            ["<esc>"] = actions.close,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
            ["<c-p>"] = actions_layout.toggle_preview,
            ["<c-t>"] = trouble.smart_open_with_trouble,
            ["<c-l>"] = custom_actions.open_and_resume,
            ["<c-x>"] = actions.delete_buffer,
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
