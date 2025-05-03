return {
  "folke/snacks.nvim",
  opts = {
    dashboard = { enabled = false },
    animate = { enabled = false },
    scroll = { enabled = false },
    -- indent = { enabled = false },
    input = {
      win = {
        -- taken from the commented line from input docs.
        relative = "cursor",
        row = -3,
        col = 0,
      },
    },
    picker = {
      layout = {
        preset = "vscode",
      },
      layouts = {
        vscode = {
          preview = false,
          layout = {
            backdrop = false,
            row = 1,
            width = 0.3,
            min_width = 70,
            height = 0.4,
            border = "rounded",
            box = "vertical",
            { win = "input", height = 1, border = "solid", title = "{title} {live} {flags}", title_pos = "center" },
            { win = "list", border = "hpad" },
            { win = "preview", title = "{preview}", border = "solid" },
          },
        },
        sidebar = {
          preview = "main",
          layout = {
            backdrop = false,
            width = 40,
            min_width = 40,
            height = 0,
            position = "left",
            border = "solid",
            box = "vertical",
            {
              win = "input",
              height = 1,
              border = "solid",
              title = "{title} {live} {flags}",
              title_pos = "center",
            },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          },
        },
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.4,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "solid" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, border = "left" },
            },
          },
        },
        ivy_split = {
          preview = "main",
          layout = {
            box = "vertical",
            backdrop = false,
            width = 0,
            height = 0.4,
            position = "bottom",
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "solid" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.6, border = "solid" },
            },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<esc>"] = { "cancel", mode = { "n", "i" } },
            ["<c-c>"] = { "cancel", mode = { "n" } },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
      sources = {
        colorschemes = {
          layout = {
            preset = "sidebar",
          },
        },
        grep_word = {
          layout = {
            preset = "ivy_split",
          },
        },
        grep = {
          layout = {
            preset = "ivy_split",
          },
        },
        keymaps = {
          layout = {
            preset = "ivy_split",
          },
        },
        explorer = {
          hidden = true,
          ignored = true,
          layout = {
            hidden = { "input" },
            auto_hide = { "input" },
          },
        },
        todo_comments = {
          layout = {
            preset = "sidebar",
          },
        },
        undo = {
          layout = {
            hidden = { "input" },
            auto_hide = { "input" },
            preset = "sidebar",
          },
        },
        lazy = {
          layout = {
            preset = "sidebar",
          },
        },
      },
    },
  },
  keys = {
    -- git
    { "<leader>gs", false },
    {
      "<leader>b/",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>fR",
      function()
        LazyVim.pick("oldfiles")()
      end,
      desc = "Recent",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({ filter = { cwd = true } })
      end,
      desc = "Recent (cwd)",
    },
  },
}
