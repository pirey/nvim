-- NOTE: dependencies
-- for ubuntu WSL, need to copy curl.h manually
-- sudo apt-get install libcurl4-gnutls-dev
-- sudo cp /usr/include/x86_64-linux-gnu/curl/* /usr/include/curl

---@diagnostic disable-next-line: unused-function, unused-local
local keys = {
  { "<leader>rr", "<Plug>RestNvim", "Run http request under cursor" },
  { "<leader>rp", "<Plug>RestNvimPreview", "Preview curl request" },
  { "<leader>rp", "<Plug>RestNvimLast", "Run last request" },
}

local function init_rest_nvim()
  os.execute("mkdir -p ~/.rest-nvim")
  vim.api.nvim_create_user_command("RestNvim", function(arg)
    local filename = arg.args
    if #filename == 0 then
      filename = "index"
    end
    if not filename:match("%.http$") then
      filename = filename .. ".http"
    end
    vim.cmd("edit ~/.rest-nvim/" .. filename)
  end, { nargs = "?", desc = "Open http client" })
end

return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    lazy = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }, -- Specify LuaRocks packages to install
    },
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = { "vhyrro/luarocks.nvim" },
    init = init_rest_nvim,
    cmd = "RestNvim",
    ft = "http",
    config = function()
      require("rest-nvim").setup({
        client = "curl",
        env_file = ".env",
        env_pattern = "\\.env$",
        env_edit_command = "tabedit",
        encode_url = true,
        skip_ssl_verification = false,
        custom_dynamic_variables = {},
        logs = {
          level = "info",
          save = true,
        },
        result = {
          split = {
            horizontal = false,
            in_place = false,
            stay_in_current_window_after_split = true,
          },
          behavior = {
            decode_url = true,
            show_info = {
              url = true,
              headers = true,
              http_info = true,
              curl_command = true,
            },
            statistics = {
              enable = true,
              ---@see https://curl.se/libcurl/c/curl_easy_getinfo.html
              stats = {
                { "total_time", title = "Time taken:" },
                { "size_download_t", title = "Download size:" },
              },
            },
            formatters = {
              json = "jq",
              html = function(body)
                if vim.fn.executable("tidy") == 0 then
                  return body, { found = false, name = "tidy" }
                end
                local fmt_body = vim.fn
                  .system({
                    "tidy",
                    "-i",
                    "-q",
                    "--tidy-mark",
                    "no",
                    "--show-body-only",
                    "auto",
                    "--show-errors",
                    "0",
                    "--show-warnings",
                    "0",
                    "-",
                  }, body)
                  :gsub("\n$", "")

                return fmt_body, { found = true, name = "tidy" }
              end,
            },
          },
          keybinds = {
            buffer_local = false,
            prev = "H",
            next = "L",
          },
        },
        highlight = {
          enable = true,
          timeout = 750,
        },
        ---Example:
        ---
        ---```lua
        ---keybinds = {
        ---  {
        ---    "<localleader>rr", "<cmd>Rest run<cr>", "Run request under the cursor",
        ---  },
        ---  {
        ---    "<localleader>rl", "<cmd>Rest run last<cr>", "Re-run latest request",
        ---  },
        ---}
        ---
        ---```
        ---@see vim.keymap.set
        keybinds = {
          {
            "<localleader>rr",
            "<cmd>Rest run<cr>",
            "Run request under the cursor",
          },
        },
      })
    end,
  },
}
