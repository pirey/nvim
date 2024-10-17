-- find a way to lazy load with correct preset
if true then
  return {}
end

return {
  "jesseleite/nvim-noirbuddy",
  dependencies = {
    { "tjdevries/colorbuddy.nvim" },
  },
  lazy = true,
  opts = {
    preset = "slate",
  },
}
