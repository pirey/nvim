if true then
  return {}
end
return {
  {
    "stevearc/dressing.nvim",
    opts = {
      select = {
        -- telescope = require("telescope.themes").get_ivy({
        --   border = false,
        -- }),
        telescope = require("telescope.themes").get_cursor(),
      },
    },
  },
}
