-- OpenCode integration
if true then return nil end

vim.g.opencode_bufnr = vim.g.opencode_bufnr or nil

-- OpenCode direct terminal
vim.g.opencode_direct_bufnr = vim.g.opencode_direct_bufnr or nil

local function open_opencode_direct()
  if vim.g.opencode_direct_bufnr and vim.api.nvim_buf_is_valid(vim.g.opencode_direct_bufnr) then
    -- Check if the buffer has a window
    local winid = vim.fn.bufwinid(vim.g.opencode_direct_bufnr)
    if winid ~= -1 then
      -- Window exists, check if there are multiple windows
      if vim.fn.winnr('$') > 1 then
        -- Close it
        vim.api.nvim_win_close(winid, false)
      end
      -- If only one window, do nothing
    else
      -- Window does not exist, open it
      vim.cmd('vert sbuffer ' .. vim.g.opencode_direct_bufnr)
    end
  else
    -- Buffer does not exist, create it
    vim.cmd('vert term opencode')
    vim.g.opencode_direct_bufnr = vim.api.nvim_get_current_buf()
    vim.bo.buflisted = false
  end
end

vim.keymap.set('n', '<leader>a', open_opencode_direct, { desc = 'Toggle OpenCode terminal window' })
