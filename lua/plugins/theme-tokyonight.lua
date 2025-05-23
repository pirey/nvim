-- make telescope borderless
local function highlight_telescope(hl, c)
  -- local prompt = "#2d3149"
  hl.TelescopeNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }
  hl.TelescopeBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopePromptTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  -- hl.TelescopePromptNormal = {
  --   bg = prompt,
  -- }
  -- hl.TelescopePromptBorder = {
  --   bg = prompt,
  --   fg = prompt,
  -- }
  -- hl.TelescopePromptTitle = {
  --   bg = prompt,
  --   fg = prompt,
  -- }
  hl.TelescopePreviewTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
end

local function highlight_telescope_fullscreen(hl, c)
  -- local prompt = "#2d3149"
  local prompt = c.bg
  hl.TelescopeNormal = {
    bg = c.bg,
    fg = c.fg,
  }
  hl.TelescopeBorder = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg,
    fg = c.bg,
  }
end

local function highlight_noice(hl, c)
  hl.NoiceCmdlinePrompt = {
    bg = c.bg_dark,
    fg = c.fg,
  }
  hl.NoiceCmdlinePopupBorder = {
    bg = c.bg,
    fg = c.bg,
  }
end

local function highlight_fold(hl, c)
  hl.Folded = {
    -- fg = c.fg_gutter,
    fg = c.fg_dark,
    bg = c.bg_dark,
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
    fg = c.fg_dark,
    bg = c.bg,
  }
end

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = false, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      -- sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      -- day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      -- hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      -- dim_inactive = false, -- dims inactive windows
      -- lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

      --- You can override specific color groups to use other groups or a hex color
      --- function will be called with a ColorScheme table
      ---@param colors ColorScheme
      on_colors = function(colors) end,

      --- You can override specific highlights to use other groups or a hex color
      --- function will be called with a Highlights and ColorScheme table
      ---@param highlights Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        -- highlight_telescope_fullscreen(highlights, colors)
        -- highlight_telescope(highlights, colors)
        -- highlight_noice(hl, c)
        highlight_fold(highlights, colors)
        -- highlight_lsp_lens(highlights, colors)
        -- highlight_flutter(highlights, colors)

        -- treesitter
        highlights["@tag.tsx"] = {}
        highlights["@tag.javascript"] = {}
        highlights["@markup.raw.markdown_inline"] = { bg = colors.none, fg = colors.blue }
      end,
    },
  },
}
