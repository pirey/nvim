vim.api.nvim_create_user_command("GitPushAsync", function()
  vim.notify("Pushing to git...", vim.log.levels.INFO)

  vim.fn.jobstart({ "git", "push" }, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            vim.schedule(function()
              vim.notify(line, vim.log.levels.INFO)
            end)
          end
        end
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
      local msg = code == 0 and "Git push completed" or "Git push failed"
      local level = code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
      vim.schedule(function()
        vim.notify(msg, level)
      end)
    end,
  })
end, {
  desc = "Run git push asynchronously",
})
