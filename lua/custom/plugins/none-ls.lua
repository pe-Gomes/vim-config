return {
  'nvimtools/none-ls.nvim',
  keys = {
    { '<leader>cf', vim.lsp.buf.format, { desc = 'Format current buffer (none-ls)' } },
  },
  config = function()
    local null_ls = require 'null-ls'
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.hadolint,
      },
    }
  end,
}
