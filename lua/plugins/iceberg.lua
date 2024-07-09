return {
  "cocopon/iceberg.vim",
  init = function()
    local custom_highlight = vim.api.nvim_create_augroup("CustomIceberg", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "iceberg",
      callback = function()
        local util = require("util")
        local bg = "#161821"
        local fg_dark = "#3e445e" -- from StatusLineNC
        local bg_dark = "#0f1117" -- from StatusLineNC
        local fg = "#c6c8d1"
        local bg_stl = "#818596"
        local fg_stl = "#17171b"
        local visual = "#272c42"
        vim.api.nvim_set_hl(0, "Bold", { bold = true })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { bg = bg, fg = "#444b71" })
        -- vim.api.nvim_set_hl(0, "Folded", { bg = bg })
        vim.api.nvim_set_hl(0, "NonText", { fg = bg })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg, bg = bg })
        vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#45493e", fg = "NONE" })
        -- vim.api.nvim_set_hl(0, "DiffChange", { bg = "#384851", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = visual, fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#53343b", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffText", { bg = "#384851", fg = "NONE" })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = fg_dark, bold = true })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#3e445e" })
        vim.api.nvim_set_hl(0, "FlashMatch", { link = "Visual" })
        vim.api.nvim_set_hl(0, "FlashLabel", { link = "CurSearch" })

        -- original highlight from iceberg.vim use this color in reverse, for some reason
        vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = bg_dark })

        -- Italic jsx/html tag attribute @tag.attribute.tsx htmlArg
        vim.api.nvim_set_hl(0, "Constant", { fg = "#a093c7", italic = true })

        -- Trouble
        vim.api.nvim_set_hl(0, "TroubleNormal", { bg = bg, fg = fg })
        vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = bg, fg = fg })

        -- Notify
        vim.api.nvim_set_hl(0, "NotifyBackground", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = bg_dark, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = bg_dark, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = bg_dark, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = bg_dark, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = bg_dark, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = fg, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = fg, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = fg, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = fg, bg = bg_dark })
        vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = fg, bg = bg_dark })

        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = fg_dark, bg = bg })

        util.patch_group_pattern("GitGutter", { bg = bg })
        util.patch_group_pattern("Diagnostic", { bg = bg })

        -- todo-comments.nvim
        -- TODO:
        vim.api.nvim_set_hl(0, "TodoSignTODO", { link = "DiagnosticInfo" })
        -- HACK:
        vim.api.nvim_set_hl(0, "TodoSignHACK", { link = "DiagnosticWarn" })
        -- FIX:
        vim.api.nvim_set_hl(0, "TodoSignFIX", { link = "DiagnosticError" })
        -- WARN:
        vim.api.nvim_set_hl(0, "TodoSignWARN", { link = "DiagnosticWarn" })
        -- PERF:
        vim.api.nvim_set_hl(0, "TodoSignPERF", { link = "DiagnosticInfo" })
        -- NOTE:
        vim.api.nvim_set_hl(0, "TodoSignNOTE", { link = "DiagnosticHint" })
        -- TEST:
        vim.api.nvim_set_hl(0, "TodoSignTEST", { link = "DiagnosticInfo" })

        -- disable lsp semantic token highlight
        -- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        --   vim.api.nvim_set_hl(0, group, {})
        -- end
      end,
      group = custom_highlight,
    })
  end,
}
