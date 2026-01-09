-- Async Git Push Function
local function git_push_async(opts)
  if not vim.fn.isdirectory('.git') then
    vim.notify('Not a git repository', vim.log.levels.ERROR)
    return
  end

  local mode = opts.args or 'window'  -- Default to 'window', or 'notify'

  if mode == 'notify' then
    vim.system({ 'git', 'push' }, { text = true }, function(obj)
      vim.schedule(function()
        if obj.code == 0 then
          vim.notify('Git push successful: ' .. (obj.stdout or ''), vim.log.levels.INFO)
        else
          vim.notify('Git push failed: ' .. (obj.stderr or 'Unknown error'), vim.log.levels.ERROR)
        end
      end)
    end)
  else  -- 'window' mode
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, 'Git Push Output')
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })

    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = 80,
      height = 10,
      row = math.floor(vim.o.lines / 2) - 5,
      col = math.floor(vim.o.columns / 2) - 40,
      style = 'minimal',
      border = 'rounded',
    })

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 'Running git push...', '' })
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })

    vim.system({ 'git', 'push' }, { text = true }, function(obj)
      vim.schedule(function()
        local lines = vim.split((obj.stdout or '') .. (obj.stderr or ''), '\n')
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

        -- Close window after 5 seconds or on keypress
        vim.defer_fn(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end, 5000)
      end)
    end)
  end
end

-- Create Vim command with nargs for mode
vim.api.nvim_create_user_command('GitPushAsync', git_push_async, {
  desc = 'Run git push asynchronously',
  nargs = '?',
  complete = function() return { 'window', 'notify' } end
})