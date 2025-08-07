vim.api.nvim_create_user_command("D2Compile", function()
  local buf = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(buf)
  local content = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
  local use_stdin = filepath == ""

  local cmd
  if use_stdin then
    cmd = { "d2", "--theme", "200", "-l", "elk", "-" }
  else
    cmd = { "d2", "--theme", "200", "-l", "elk", filepath }
  end

  local handle = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    stdin = use_stdin and "pipe" or nil,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          print(line)
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.notify(line, vim.log.levels.ERROR)
          end
        end
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        vim.notify("D2 compile succeeded", vim.log.levels.INFO)
      else
        vim.notify("D2 compile failed", vim.log.levels.ERROR)
      end
    end,
  })

  if use_stdin then
    vim.fn.chansend(handle, content)
    vim.fn.chanclose(handle, "stdin")
  end
end, {
  desc = "Compile current file with D2",
})
