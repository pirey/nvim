if true then
  return {}
end
return {
  {
    "rcarriga/nvim-notify",
    enabled = false,
    opts = {
      render = "minimal",
      mininum_width = 50,
      max_width = 80,
      -- max_height = 5,
      stages = "static",
      -- fps = 60,
      -- top_down = false,
    },
  },
}
