local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

M.capabilities = capabilities

return M
