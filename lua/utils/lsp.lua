---@class util.lsp
local M = {}

---@param on_attach fun(client:vim.lsp.Client, buffer)
---@param name? string
function M.on_attach(on_attach, name)
  return vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf ---@type number
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client and (not name or client.name == name) then
        return on_attach(client, buffer)
      end
    end,
  })
end

---@param opts? lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type vim.lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  else
    ---@diagnostic disable-next-line: deprecated
    ret = vim.lsp.get_active_clients(opts)
    if opts and opts.method then
      ---@param client vim.lsp.Client
      ret = vim.tbl_filter(function(client)
        return client.supports_method(opts.method, { bufnr = opts.bufnr })
      end, ret)
    end
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

---@param from string
---@param to string
---@param rename? fun()
function M.on_rename(from, to, rename)
  local changes = {
    files = {
      oldUri = vim.uri_from_fname(from),
      newUri = vim.uri_from_fname(to),
    },
  }

  local clients = M.get_clients()

  for _, client in ipairs(clients) do
    if client.supports_method 'workspace/willRenameFiles' then
      local res = client.request_sync('workspace/willRenameFiles', changes, 1000, 0)
      if res and res.result ~= nil then
        vim.lsp.util.apply_workspace_edit(res.result, client.offset_encoding)
      end
    end
  end

  if rename then
    rename()
  end

  for _, client in ipairs(clients) do
    if client.supports_method 'workspace/didRenameFiles' then
      client.notify('workspace/DidRenameFiles', changes)
    end
  end
end

return M
