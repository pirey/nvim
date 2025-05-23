return {
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    enabled = false, -- using too much resource?
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      -- keys[#keys + 1] = { "<c-k>", vim.lsp.buf.hover }
      keys[#keys + 1] = {
        "<leader>k",
        function()
          vim.lsp.buf.hover()
        end,
      }

      keys[#keys + 1] = { "gr", false }
    end,
    opts = {
      inlay_hints = {
        enabled = false,
      },
      servers = {
        -- tailwindcss = {
        --   filetypes_include = { "blade" },
        --   root_dir = function(fname)
        --     return require("lspconfig.util").root_pattern(
        --       "tailwind.config.js",
        --       "tailwind.config.cjs",
        --       "tailwind.config.mjs",
        --       "tailwind.config.ts",
        --       "postcss.config.js",
        --       "postcss.config.cjs",
        --       "postcss.config.mjs",
        --       "postcss.config.ts"
        --     )(fname)
        --   end,
        -- },
        vtsls = {
          -- root_dir = require("lspconfig.util").root_pattern(".git"),
          -- root_dir = require("lspconfig.util").find_git_ancestor,
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "non-relative",
              },
            },
          },
        },
        -- purescriptls = {
        --   settings = {
        --     purescript = {
        --       formatter = "purs-tidy",
        --     },
        --   },
        -- },
        elmls = {
          mason = false,
          -- root_dir = require("lspconfig.util").root_pattern("elm.json"),
          init_options = {
            disableElmLSDiagnostics = true,
            elmReviewDiagnostics = "off",
            onlyUpdateDiagnosticsOnSave = true,
            skipInstallPackageConfirmation = false,
          },
          settings = {},
        },
        hls = {
          -- use hls managed by ghcup instead of mason,
          -- and use default config from nvim-lspconfig
          mason = false,
        },
        -- install gopls
        -- go install golang.org/x/tools/gopls@latest
        gopls = {
          mason = false,
        },
      },
    },
  },
}
