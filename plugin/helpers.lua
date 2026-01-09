-- Async Git Push Function
local function git_push_async()
  if not vim.fn.isdirectory('.git') then
    vim.notify('Not a git repository', vim.log.levels.ERROR)
    return
  end

  vim.system({ 'git', 'push' }, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        vim.notify('Git push successful', vim.log.levels.INFO)
      else
        vim.notify('Git push failed: ' .. (obj.stderr or 'Unknown error'), vim.log.levels.ERROR)
      end
    end)
  end)
end

-- Create Vim command
vim.api.nvim_create_user_command('GitPushAsync', git_push_async, { desc = 'Run git push asynchronously' })