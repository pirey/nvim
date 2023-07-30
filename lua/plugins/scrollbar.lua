local function get_minor_version()
  local v = vim.version()
  print("minor: " .. v.minor)
  return v.minor
end

if get_minor_version() < 10 then
  return {
    {
      "petertriho/nvim-scrollbar",
      config = true,
    },
  }
else
  return {
    {
      "lewis6991/satellite.nvim",
      config = true,
    },
  }
end
