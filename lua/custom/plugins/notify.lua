return {
  'rcarriga/nvim-notify',
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>uh',
      ':Telescope notify<CR>',
      desc = 'Notifications history (Telescope)',
    },
  },
  opts = {
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      local buf = vim.api.nvim_win_get_buf(win)
      ---@diagnostic disable-next-line: deprecated
      vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
    background_colour = 'NotifyBackground',
    fps = 60,
    icons = {
      DEBUG = '',
      ERROR = '',
      INFO = '',
      TRACE = '✎',
      WARN = '',
    },
    level = 2,
    minimum_width = 50,
    render = 'compact',
    stages = 'static',
    time_formats = {
      notification = '%T',
      notification_history = '%FT%T',
    },
    timeout = 3000,
    top_down = true,
  },
}
