return {
  'smjonas/inc-rename.nvim',
  cmd = 'IncRename',
  opts = {},
  keys = {
    {
      '<leader>cr',
      function()
        return ':IncRename ' .. vim.fn.expand '<cword>'
      end,
      expr = true,
    },
  },
}