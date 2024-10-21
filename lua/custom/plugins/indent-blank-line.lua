return {
  'lukas-reineke/indent-blankline.nvim',
  version = '2.20.7',
  event = 'User FilePost',
  opts = function()
    return require('plugins.configs.others').blankline
  end,
  config = function(_, opts)
    require('core.utils').load_mappings 'blankline'
    dofile(vim.g.base46_cache .. 'blankline')
    require('indent_blankline').setup(opts)
  end,
}
