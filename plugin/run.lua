-- Globals
local output_file = vim.fn.stdpath('cache') .. '/run_output.txt'
vim.g.run_default_mode = vim.g.run_default_mode or 'split'
vim.g.run_output_mode = vim.g.run_output_mode or 'split'

-- Mode functions
local function run_notify(cmd_str)
  vim.system({ 'sh', '-c', cmd_str }, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        vim.notify(cmd_str .. ' successful: ' .. (obj.stdout or ''), vim.log.levels.INFO)
      else
        vim.notify(cmd_str .. ' failed: ' .. (obj.stderr or 'Unknown error'), vim.log.levels.ERROR)
      end
    end)
  end)
end

local function run_split(cmd_str)
  local buf = vim.fn.bufnr('run://output')
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, 'run://output')
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
    -- Load persisted output
    if vim.fn.filereadable(output_file) == 1 then
      local lines = vim.fn.readfile(output_file)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
  end
  local win = vim.fn.bufwinid(buf)
  if win == -1 then
    vim.cmd('botright split')
    vim.api.nvim_win_set_buf(0, buf)
  else
    vim.api.nvim_set_current_win(win)
  end

  -- Add separator
  local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local separator = { '', '--- ' .. cmd_str .. ' ---', '' }
  local new_lines = vim.list_extend(current_lines, separator)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
  vim.fn.writefile(new_lines, output_file)

  -- Start job for streaming
  vim.fn.jobstart({ 'sh', '-c', cmd_str }, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= '' then table.insert(lines, line) end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.fn.writefile(lines, output_file)
        end)
      end
    end,
    on_stderr = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= '' then table.insert(lines, line) end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.fn.writefile(lines, output_file)
        end)
      end
    end,
  })
end

local function run_preview(cmd_str)
  local buf = vim.fn.bufnr('run://output')
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, 'run://output')
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
    -- Load persisted output
    if vim.fn.filereadable(output_file) == 1 then
      local lines = vim.fn.readfile(output_file)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
  end
  vim.cmd('pedit run://output')

  -- Add separator
  vim.schedule(function()
    local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local separator = { '', '--- ' .. cmd_str .. ' ---', '' }
    local new_lines = vim.list_extend(current_lines, separator)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
    vim.fn.writefile(new_lines, output_file)

    -- Start job for streaming
    vim.fn.jobstart({ 'sh', '-c', cmd_str }, {
      stdout_buffered = false,
      stderr_buffered = false,
      on_stdout = function(job_id, data, event)
        if data then
          vim.schedule(function()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            for _, line in ipairs(data) do
              if line ~= '' then table.insert(lines, line) end
            end
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.fn.writefile(lines, output_file)
          end)
        end
      end,
      on_stderr = function(job_id, data, event)
        if data then
          vim.schedule(function()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            for _, line in ipairs(data) do
              if line ~= '' then table.insert(lines, line) end
            end
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.fn.writefile(lines, output_file)
          end)
        end
      end,
    })
  end)
end

local function run_floating(cmd_str)
  local buf = vim.fn.bufnr('run://output')
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, 'run://output')
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
    -- Load persisted output
    if vim.fn.filereadable(output_file) == 1 then
      local lines = vim.fn.readfile(output_file)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
  end

  local win = vim.api.nvim_open_win(buf, false, {
    relative = 'editor',
    width = 80,
    height = 10,
    row = math.floor(vim.o.lines / 2) - 5,
    col = math.floor(vim.o.columns / 2) - 40,
    style = 'minimal',
    border = 'rounded',
  })

  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, 'n', '<esc>', '<cmd>close<CR>', { noremap = true, silent = true })

  -- Add separator
  local separator = { '', '--- ' .. cmd_str .. ' ---', '' }
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, separator)
  vim.fn.writefile(separator, output_file)

  -- Start job for streaming
  vim.fn.jobstart({ 'sh', '-c', cmd_str }, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= '' then table.insert(lines, line) end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.fn.writefile(lines, output_file)
        end)
      end
    end,
    on_stderr = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= '' then table.insert(lines, line) end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          vim.fn.writefile(lines, output_file)
        end)
      end
    end,
  })

  -- Close window after 5 seconds (but since streaming, maybe keep open longer or remove auto-close)
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 10000)  -- Increased to 10s for long commands
end

-- Main functions
local function async_run(opts)
  local input = opts.args or ''
  local mode = vim.g.run_default_mode
  local cmd_str

  -- Check if input starts with quote, treat as single command
  if input:sub(1,1) == '"' then
    cmd_str = input:sub(2, -2)  -- Remove quotes
  else
    cmd_str = input
  end

  if not cmd_str or cmd_str == 'help' then
    vim.notify('Usage: Run <command>\nMode is set via vim.g.run_default_mode (default: split)\nExamples:\n  :Run git status\n  :Run "ls -la"\n  :Run "git push"', vim.log.levels.INFO)
    return
  end

  -- cmd_str is the full command string

  if mode == 'notify' then
    run_notify(cmd_str)
  elseif mode == 'split' then
    run_split(cmd_str)
  elseif mode == 'preview' then
    run_preview(cmd_str)
  else  -- 'floating'
    run_floating(cmd_str)
  end
end

local function show_output(opts)
  local mode = opts.args or vim.g.run_output_mode

  if not (mode == 'split' or mode == 'preview' or mode == 'floating') then
    mode = 'split'
  end

  local buf = vim.fn.bufnr('run://output')
  if buf == -1 then
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, 'run://output')
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
    -- Load persisted output
    if vim.fn.filereadable(output_file) == 1 then
      local lines = vim.fn.readfile(output_file)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
  end

  if mode == 'split' then
    local win = vim.fn.bufwinid(buf)
    if win == -1 then
      vim.cmd('botright split')
      vim.api.nvim_win_set_buf(0, buf)
    else
      vim.api.nvim_set_current_win(win)
    end
  elseif mode == 'preview' then
    vim.cmd('pedit run://output')
  else  -- floating
    local win = vim.api.nvim_open_win(buf, false, {
      relative = 'editor',
      width = 80,
      height = 20,  -- Larger for viewing history
      row = math.floor(vim.o.lines / 2) - 10,
      col = math.floor(vim.o.columns / 2) - 40,
      style = 'minimal',
      border = 'rounded',
    })
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, 'n', '<esc>', '<cmd>close<CR>', { noremap = true, silent = true })
  end
end

-- Command creations
vim.api.nvim_create_user_command('Run', async_run, {
  desc = 'Run shell command asynchronously with output display',
  nargs = '+',
  complete = function() return {} end
})

vim.api.nvim_create_user_command('RunSplit', function(opts) run_split(opts.args) end, {
  desc = 'Run shell command asynchronously in split mode',
  nargs = '+'
})
vim.api.nvim_create_user_command('RunFloating', function(opts) run_floating(opts.args) end, {
  desc = 'Run shell command asynchronously in floating mode',
  nargs = '+'
})
vim.api.nvim_create_user_command('RunPreview', function(opts) run_preview(opts.args) end, {
  desc = 'Run shell command asynchronously in preview mode',
  nargs = '+'
})
vim.api.nvim_create_user_command('RunNotify', function(opts) run_notify(opts.args) end, {
  desc = 'Run shell command asynchronously with notify',
  nargs = '+'
})

vim.api.nvim_create_user_command('RunOutput', show_output, {
  desc = 'Show the run output buffer',
  nargs = '?',
  complete = function() return { 'floating', 'preview', 'split' } end
})

-- Abbreviations
vim.cmd([[
  cabbrev <expr> run getcmdtype() == ':' && getcmdline() =~# '^run' ? 'Run' : 'run'
]])
