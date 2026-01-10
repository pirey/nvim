-- Globals
local output_file = vim.fn.stdpath("cache") .. "/run_output.txt"
vim.g.run_default_mode = vim.g.run_default_mode or "split"
vim.g.run_output_mode = vim.g.run_output_mode or "split"
local current_job_id = nil
local history_buf = nil
local current_buf = nil

-- Helper to get or create history buffer
local function get_history_buf()
  if not history_buf or not vim.api.nvim_buf_is_valid(history_buf) then
    history_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(history_buf, "run://output")
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = history_buf })
    vim.api.nvim_set_option_value("bufhidden", "hide", { buf = history_buf })
    -- Load persisted output
    if vim.fn.filereadable(output_file) == 1 then
      local lines = vim.fn.readfile(output_file)
      vim.api.nvim_buf_set_lines(history_buf, 0, -1, false, lines)
    end
  end
  return history_buf
end

-- Helper to get or create current buffer
local function get_current_buf()
  if not current_buf or not vim.api.nvim_buf_is_valid(current_buf) then
    current_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(current_buf, "run://current")
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = current_buf })
    vim.api.nvim_set_option_value("bufhidden", "hide", { buf = current_buf })
  end
  return current_buf
end

-- Mode functions
local function run_notify(cmd_str)
  vim.system({ "sh", "-c", cmd_str }, { text = true }, function(obj)
    vim.schedule(function()
      if obj.code == 0 then
        vim.notify(cmd_str .. " successful: " .. (obj.stdout or ""), vim.log.levels.INFO)
      else
        vim.notify(cmd_str .. " failed: " .. (obj.stderr or "Unknown error"), vim.log.levels.ERROR)
      end
    end)
  end)
end

local function run_split(cmd_str)
  local buf = get_current_buf()
  local win = vim.fn.bufwinid(buf)
  if win == -1 then
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, buf)
  else
    vim.api.nvim_set_current_win(win)
  end

  -- Clear current buffer for new command
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Running " .. cmd_str .. "...", "" })

  -- Start job for streaming
  current_job_id = vim.fn.jobstart({ "sh", "-c", cmd_str }, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(lines, line)
            end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        end)
      end
    end,
    on_stderr = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(lines, line)
            end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        end)
      end
    end,
    on_exit = function(job_id, exit_code, event)
      current_job_id = nil
      vim.schedule(function()
        -- Append to history
        local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local hist_buf = get_history_buf()
        local hist_lines = vim.api.nvim_buf_get_lines(hist_buf, 0, -1, false)
        local separator = { "", "--- " .. cmd_str .. " ---", "" }
        hist_lines = vim.list_extend(hist_lines, separator)
        hist_lines = vim.list_extend(hist_lines, current_lines)
        vim.api.nvim_buf_set_lines(hist_buf, 0, -1, false, hist_lines)
        vim.fn.writefile(hist_lines, output_file)
        vim.notify("Command exited with code " .. exit_code, vim.log.levels.INFO)
      end)
    end,
  })
end

local function run_preview(cmd_str)
  local buf = get_current_buf()
  vim.cmd("pedit run://current")

  -- Clear current buffer for new command
  vim.schedule(function()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Running " .. cmd_str .. "...", "" })

    -- Start job for streaming
    current_job_id = vim.fn.jobstart({ "sh", "-c", cmd_str }, {
      stdout_buffered = false,
      stderr_buffered = false,
      on_stdout = function(job_id, data, event)
        if data then
          vim.schedule(function()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            for _, line in ipairs(data) do
              if line ~= "" then
                table.insert(lines, line)
              end
            end
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          end)
        end
      end,
      on_stderr = function(job_id, data, event)
        if data then
          vim.schedule(function()
            local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
            for _, line in ipairs(data) do
              if line ~= "" then
                table.insert(lines, line)
              end
            end
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
          end)
        end
      end,
      on_exit = function(job_id, exit_code, event)
        current_job_id = nil
        vim.schedule(function()
          -- Append to history
          local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          local hist_buf = get_history_buf()
          local hist_lines = vim.api.nvim_buf_get_lines(hist_buf, 0, -1, false)
          local separator = { "", "--- " .. cmd_str .. " ---", "" }
          hist_lines = vim.list_extend(hist_lines, separator)
          hist_lines = vim.list_extend(hist_lines, current_lines)
          vim.api.nvim_buf_set_lines(hist_buf, 0, -1, false, hist_lines)
          vim.fn.writefile(hist_lines, output_file)
          vim.notify("Command exited with code " .. exit_code, vim.log.levels.INFO)
        end)
      end,
    })
  end)
end

local function run_floating(cmd_str)
  local buf = get_current_buf()

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = 80,
    height = 10,
    row = math.floor(vim.o.lines / 2) - 5,
    col = math.floor(vim.o.columns / 2) - 40,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", "<cmd>close<CR>", { noremap = true, silent = true })

  -- Clear current buffer for new command
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Running " .. cmd_str .. "...", "" })

  -- Start job for streaming
  current_job_id = vim.fn.jobstart({ "sh", "-c", cmd_str }, {
    stdout_buffered = false,
    stderr_buffered = false,
    on_stdout = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(lines, line)
            end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        end)
      end
    end,
    on_stderr = function(job_id, data, event)
      if data then
        vim.schedule(function()
          local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          for _, line in ipairs(data) do
            if line ~= "" then
              table.insert(lines, line)
            end
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        end)
      end
    end,
    on_exit = function(job_id, exit_code, event)
      current_job_id = nil
      vim.schedule(function()
        -- Append to history
        local current_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        local hist_buf = get_history_buf()
        local hist_lines = vim.api.nvim_buf_get_lines(hist_buf, 0, -1, false)
        local separator = { "", "--- " .. cmd_str .. " ---", "" }
        hist_lines = vim.list_extend(hist_lines, separator)
        hist_lines = vim.list_extend(hist_lines, current_lines)
        vim.api.nvim_buf_set_lines(hist_buf, 0, -1, false, hist_lines)
        vim.fn.writefile(hist_lines, output_file)
        vim.notify("Command exited with code " .. exit_code, vim.log.levels.INFO)
      end)
    end,
  })

  -- Close window after 10s
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 10000)
end

-- Main functions
local function async_run(opts)
  local input = opts.args or ""
  local mode = vim.g.run_default_mode
  local cmd_str

  -- Check if input starts with quote, treat as single command
  if input:sub(1, 1) == '"' then
    cmd_str = input:sub(2, -2) -- Remove quotes
  else
    cmd_str = input
  end

  if not cmd_str or cmd_str == "help" then
    vim.notify(
      'Usage: Run <command>\nMode is set via vim.g.run_default_mode (default: split)\nExamples:\n  :Run git status\n  :Run "ls -la"\n  :Run "git push"',
      vim.log.levels.INFO
    )
    return
  end

  -- cmd_str is the full command string

  if mode == "notify" then
    run_notify(cmd_str)
  elseif mode == "split" then
    run_split(cmd_str)
  elseif mode == "preview" then
    run_preview(cmd_str)
  else -- 'floating'
    run_floating(cmd_str)
  end
end

local function show_output(opts)
  local mode = opts.args or vim.g.run_output_mode

  if not (mode == "split" or mode == "preview" or mode == "floating") then
    mode = "split"
  end

  local buf = get_history_buf()

  if mode == "split" then
    local win = vim.fn.bufwinid(buf)
    if win == -1 then
      vim.cmd("botright split")
      vim.api.nvim_win_set_buf(0, buf)
    else
      vim.api.nvim_set_current_win(win)
    end
  elseif mode == "preview" then
    vim.cmd("pedit run://output")
  else -- floating
    local win = vim.api.nvim_open_win(buf, false, {
      relative = "editor",
      width = 80,
      height = 20, -- Larger for viewing history
      row = math.floor(vim.o.lines / 2) - 10,
      col = math.floor(vim.o.columns / 2) - 40,
      style = "minimal",
      border = "rounded",
    })
    vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", "<cmd>close<CR>", { noremap = true, silent = true })
  end
end

-- Command creations
vim.api.nvim_create_user_command("Run", async_run, {
  desc = "Run shell command asynchronously with output display",
  nargs = "+",
  complete = function()
    return {}
  end,
})

vim.api.nvim_create_user_command("RunSplit", function(opts)
  run_split(opts.args)
end, {
  desc = "Run shell command asynchronously in split mode",
  nargs = "+",
})
vim.api.nvim_create_user_command("RunFloating", function(opts)
  run_floating(opts.args)
end, {
  desc = "Run shell command asynchronously in floating mode",
  nargs = "+",
})
vim.api.nvim_create_user_command("RunPreview", function(opts)
  run_preview(opts.args)
end, {
  desc = "Run shell command asynchronously in preview mode",
  nargs = "+",
})
vim.api.nvim_create_user_command("RunNotify", function(opts)
  run_notify(opts.args)
end, {
  desc = "Run shell command asynchronously with notify",
  nargs = "+",
})

vim.api.nvim_create_user_command("RunOutput", show_output, {
  desc = "Show the run output buffer",
  nargs = "?",
  complete = function()
    return { "floating", "preview", "split" }
  end,
})

vim.api.nvim_create_user_command("RunStop", function()
  if current_job_id then
    vim.fn.jobstop(current_job_id)
    current_job_id = nil
    vim.notify("Stopped running command", vim.log.levels.INFO)
  else
    vim.notify("No running command to stop", vim.log.levels.WARN)
  end
end, {
  desc = "Stop the currently running command",
})

vim.api.nvim_create_user_command("RunToggleCurrent", function()
  local buf = get_current_buf()
  local win = vim.fn.bufwinid(buf)
  if win ~= -1 then
    vim.api.nvim_win_close(win, true)
  else
    -- Open in split by default
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, buf)
  end
end, {
  desc = "Toggle the current command output window",
})

vim.api.nvim_create_user_command("RunToggleOutput", function()
  local buf = get_history_buf()
  local win = vim.fn.bufwinid(buf)
  if win ~= -1 then
    vim.api.nvim_win_close(win, true)
  else
    -- Open in run_output_mode
    local mode = vim.g.run_output_mode
    if mode == "split" then
      vim.cmd("botright split")
      vim.api.nvim_win_set_buf(0, buf)
    elseif mode == "preview" then
      vim.cmd("pedit run://output")
    else -- floating
      local win = vim.api.nvim_open_win(buf, false, {
        relative = "editor",
        width = 80,
        height = 20,
        row = math.floor(vim.o.lines / 2) - 10,
        col = math.floor(vim.o.columns / 2) - 40,
        style = "minimal",
        border = "rounded",
      })
      vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(buf, "n", "<esc>", "<cmd>close<CR>", { noremap = true, silent = true })
    end
  end
end, {
  desc = "Toggle the output history window",
})

-- Abbreviations
vim.cmd([[
  cabbrev <expr> run getcmdtype() == ':' && getcmdline() =~# '^run' ? 'Run' : 'run'
]])
