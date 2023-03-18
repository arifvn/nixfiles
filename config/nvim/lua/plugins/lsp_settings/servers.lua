local M = {}

local jsonls = {
  json = {
    schemas = require('schemastore').json.schemas(),
    validate = { enable = true },
  },
}

local lua_ls = {
  Lua = {
    diagnostics = { globals = { 'vim' } },
    workspace = { checkThirdParty = false },
    telemetry = { enable = false },
    completion = { callSnippet = 'Replace' },
  },
}

M.servers = {
  emmet_ls = {},
  cssls = {},
  tailwindcss = {},
  html = {},
  jsonls = jsonls,
  svelte = {},
  tsserver = {},
  marksman = {},
  lua_ls = lua_ls,
}

return M
