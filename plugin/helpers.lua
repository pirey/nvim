-- Async Command Runner
local function async_cmd(opts)
  local args = vim.split(opts.args or '', ' ', { plain = true })
  local last_arg = args[#args]
  local mode = 'preview'  -- Default
  local cmd_parts = args

  if last_arg == 'floating' or last_arg == 'preview' or last_arg == 'notify' then
    mode = last_arg
    cmd_parts = vim.list_slice(args, 1, #args - 1)
  end

  local cmd_str = table.concat(cmd_parts, ' ')

  if not cmd_str or cmd_str == 'help' then
    vim.notify('Usage: Run <command> [mode]\nModes: preview (default), floating, notify\nExamples:\n  :Run git status floating\n  :Run ls -la preview\n  :Run echo hello notify', vim.log.levels.INFO)
    return
  end

  local cmd = cmd_parts
  local running_msg = 'Running ' .. cmd_str .. '...'

  if mode == 'notify' then
    vim.system(cmd, { text = true }, function(obj)
      vim.schedule(function()
        if obj.code == 0 then
          vim.notify(cmd_str .. ' successful: ' .. (obj.stdout or ''), vim.log.levels.INFO)
        else
          vim.notify(cmd_str .. ' failed: ' .. (obj.stderr or 'Unknown error'), vim.log.levels.ERROR)
        end
      end)
    end)
  elseif mode == 'preview' then
    vim.cmd('pedit Command Output')
    vim.schedule(function()
      local buf = vim.fn.bufnr('Command Output')
      if buf ~= -1 then
        vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
        vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { running_msg, '' })

        vim.system(cmd, { text = true }, function(obj)
          vim.schedule(function()
            local lines = vim.split((obj.stdout or '') .. (obj.stderr or ''), '\n')
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          end)
        end)
      end
    end)
  else  -- 'floating' mode
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, 'Command Output')
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })

    local win = vim.api.nvim_open_win(buf, false, {
      relative = 'editor',
      width = 80,
      height = 10,
      row = math.floor(vim.o.lines / 2) - 5,
      col = math.floor(vim.o.columns / 2) - 40,
      style = 'minimal',
      border = 'rounded',
    })

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { running_msg, '' })
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'n', '<esc>', '<cmd>close<CR>', { noremap = true, silent = true })

    vim.system(cmd, { text = true }, function(obj)
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

-- Create Vim command
vim.api.nvim_create_user_command('Run', async_cmd, {
  desc = 'Run shell command asynchronously with output display',
  nargs = '+',
  complete = function(arg_lead, cmd_line, cursor_pos)
    if #vim.split(cmd_line, ' ') > 2 then
      return { 'floating', 'preview', 'notify' }
    else
      return {}  -- No completion for command itself
    end
  end
})

vim.cmd([[
  cabbrev <expr> run getcmdtype() == ':' && getcmdline() =~# '^run' ? 'Run' : 'run'
]])
