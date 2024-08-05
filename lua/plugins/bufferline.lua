local bg_hlg = "Normal"

return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
    keys = {
      {
        "<leader>bo",
        "<Cmd>only<CR><Cmd>BufferLineCloseOthers<CR>",
        desc = "Delete Other Buffers and windows",
      },
    },
    opts = {
      options = {
        offsets = {},
        diagnostics = false,
        always_show_bufferline = true,
      },
      highlights = {
        fill = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        background = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        tab = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        tab_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        tab_separator = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        tab_separator_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        tab_close = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        close_button = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        close_button_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        close_button_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        buffer_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        buffer_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
          bold = true,
        },
        numbers = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        numbers_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        numbers_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        diagnostic = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        diagnostic_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        diagnostic_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        hint = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        hint_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        hint_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
          fg = {
            attribute = "fg",
            highlight = bg_hlg,
          },
        },
        hint_diagnostic = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        hint_diagnostic_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        hint_diagnostic_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        info = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        info_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        info_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        info_diagnostic = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
          fg = {
            attribute = "fg",
            highlight = bg_hlg,
          },
        },
        info_diagnostic_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        info_diagnostic_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        warning = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        warning_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        warning_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        warning_diagnostic = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        warning_diagnostic_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        warning_diagnostic_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        error = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        error_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        error_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        error_diagnostic = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        error_diagnostic_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        error_diagnostic_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        modified = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        modified_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        modified_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        duplicate_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        duplicate_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        duplicate = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        separator_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        separator_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        separator = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        indicator_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        indicator_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        pick_selected = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        pick_visible = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        pick = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        offset_separator = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
        trunc_marker = {
          bg = {
            attribute = "bg",
            highlight = bg_hlg,
          },
        },
      },
    },
  },
}
