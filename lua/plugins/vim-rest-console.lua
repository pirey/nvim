return {
  "diepm/vim-rest-console",
  init = function()
    os.execute("mkdir -p ~/.vim-rest-console")
    local function handle_open_console(arg)
      local filename = arg.args
      if #filename == 0 then
        filename = "index"
      end
      vim.cmd("tabedit ~/.vim-rest-console/" .. filename .. ".rest")
    end
    local opts = { nargs = "?", desc = "Open HTTP Console" }
    vim.api.nvim_create_user_command("VRC", handle_open_console, opts)
    vim.api.nvim_create_user_command("Http", handle_open_console, opts)
    vim.cmd("autocmd! BufRead,BufNewFile __REST_response__ setlocal ft=json")

    -- vim.g.vrc_set_default_mapping = 0
    vim.g.vrc_response_default_content_type = "application/json"
    -- vim.g.vrc_output_buffer_name = "VRC_OUTPUT.json"
    vim.g.vrc_auto_format_response_patterns = {
      json = "jq",
    }
    vim.g.vrc_curl_opts = {
      ["--silent"] = "",
    }
  end,
}
