-- make telescope borderless
local function highlight_telescope(hl, c)
  local prompt = "#2d3149"
  hl.TelescopeNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }
  hl.TelescopeBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.NoiceCmdlinePopupBorder = {
    bg = c.bg,
    fg = c.bg,
  }
end

local function highlight_fold(hl, c)
  hl.Folded = {
    fg = c.fg_gutter,
    bg = c.bg,
  }
end

local function highlight_lsp_lens(hl, c)
  hl.LspLens = {
    fg = c.fg_gutter,
    bg = c.bg,
  }
end

local function highlight_flutter(hl, c)
  hl.FlutterClosingTags = {
    fg = c.fg_gutter,
    bg = c.bg,
  }
end

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "normal", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      on_highlights = function(hl, c)
        highlight_telescope(hl, c)
        highlight_fold(hl, c)
        highlight_lsp_lens(hl, c)
        highlight_flutter(hl, c)
      end,
    },
  },
}
