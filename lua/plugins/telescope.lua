local Util = require("lazyvim.util")

local function get_filename_from_path(path)
    local tail = string.match(path, "[^/]+$")
    return tail
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
        path_display = function(_, path)
          local tail = get_filename_from_path(path)
          return string.format("%s (%s)", tail, path)
        end,
      },
      pickers = {
        lsp_references = {
          show_line = false,
        }
      }
    },
  },
}
