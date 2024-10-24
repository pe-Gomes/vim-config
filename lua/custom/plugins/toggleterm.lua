return {
  'akinsho/toggleterm.nvim',
  keys = {
    {
      '<C-t>',
      '<Cmd>exe v:count1 . "ToggleTerm"<CR>',
      silent = true,
      desc = 'Open new terminal (toggleterm)',
    },
    {
      '<leader>ta',
      '<Cmd>ToggleTermToggleAll<CR>',
      silent = true,
      desc = 'Toggle all terminal sessions (toggleterm)',
    },
  },
  config = function()
    local toggleterm = require 'toggleterm'
    toggleterm.setup()

    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]])
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
  end,
}
