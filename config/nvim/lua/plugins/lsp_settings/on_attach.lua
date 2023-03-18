local M = {}

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false

  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  if client.name == 'tsserver' then
    keymap('n', '<leader>rf', '<cmd>TypescriptRenameFile<cr>', opts) -- rename file and update imports
    keymap('n', '<leader>oi', '<cmd>TypescriptOrganizeImports<cr>', opts) -- organize imports (not in youtube nvim video)
    keymap('n', '<leader>ru', '<cmd>TypescriptRemoveUnused<cr>', opts) -- remove unused variables (not in youtube nvim video)
  end

  keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
  keymap('n', '<leader>rn', '<cmd>Lspsaga rename<cr>', opts)
  keymap('n', '<leader>d', '<cmd>Lspsaga show_line_diagnostics<cr>', opts)
  keymap('n', '<leader>D', '<cmd>Lspsaga show_cursor_diagnostics<cr>', opts)
  keymap('n', '<leader>p', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opts)
  keymap('n', '<leader>n', '<cmd>Lspsaga diagnostic_jump_next<cr>', opts)
  keymap('n', '<leader>h', '<cmd>Lspsaga hover_doc<cr>', opts)
  keymap('n', '<leader>u', '<cmd>TroubleToggle<cr>')
  keymap('n', '<leader>l', '<cmd>LspInfo<cr>', opts)
  keymap('n', '<leader>td', '<cmd>lua vim.lsp.buf.type_definition<cr>', opts)
  keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format { async = true }<cr>', opts)
  keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  keymap('n', 'gf', '<cmd>Lspsaga lsp_finder<cr>', opts)
  keymap('n', 'gd', '<cmd>Lspsaga peek_definition<cr>', opts)
  keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)

  -- sign column
  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- virtual text
  vim.diagnostic.config {
    focusable = false,
    virtual_text = false,
    severity_sort = true,
    underline = true,
    float = {
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  }
end

return M
