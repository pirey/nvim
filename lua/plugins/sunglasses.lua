return {
  "miversen33/sunglasses.nvim",
  config = function()
    require("sunglasses").setup({
      filter_percent = 0.65,
      filter_type = "SHADE",
      log_level = "ERROR",
      refresh_timer = 5,
      excluded_filetypes = {
        "dashboard",
        "lspsagafinder",
        "packer",
        "checkhealth",
        "mason",
        "NvimTree",
        "neo-tree",
        "plugin",
        "lazy",
        "TelescopePrompt",
        "alpha",
        "toggleterm",
        "sagafinder",
        "better_term",
        "fugitiveblame",
        "starter",
        "NeogitPopup",
        "NeogitStatus",
        "DiffviewFiles",
        "DiffviewFileHistory",
        "DressingInput",
        "spectre_panel",
        "zsh",
        "registers",
        "startuptime",
        "OverseerList",
        "Navbuddy",
        "noice",
        "notify",
        "saga_codeaction",
        "sagarename",
        -- additional
        "httpResult",
        "http",
      },
      excluded_highlights = {
        "WinSeparator",
        { "lualine_.*", glob = true },
      },
    })
    -- disable by default
    -- vim.cmd("SunglassesDisable")
  end,
}
