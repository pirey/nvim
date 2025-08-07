vim.api.nvim_create_user_command("D2Compile", function()
  local buf = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(buf)
  local is_unsaved = filepath == ""

  local content = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
  local cmd = is_unsaved
    and { "d2", "--theme", "200", "-l", "elk", "-" }
    or  { "d2", "--theme", "200", "-l", "elk", filepath }

  local output = {}
  local handle = vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    stdin = is_unsaved and "pipe" or nil,

    on_stdout = function(_, data)
      if is_unsaved and data then
        output = data
      end
    end,

    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.schedule(function()
              vim.notify(line, vim.log.levels.ERROR)
            end)
          end
        end
      end
    end,

    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("D2 compile succeeded", vim.log.levels.INFO)
          if is_unsaved then
            vim.cmd("vnew")
            vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
            vim.bo.filetype = "d2"
          end
        else
          vim.notify("D2 compile failed", vim.log.levels.ERROR)
        end
      end)
    end,
  })

  if is_unsaved then
    vim.fn.chansend(handle, content)
    vim.fn.chanclose(handle, "stdin")
  end
end, {
  desc = "Compile current file with D2",
})

