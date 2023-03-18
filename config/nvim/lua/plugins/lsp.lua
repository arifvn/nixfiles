return {
  'neovim/nvim-lspconfig',

  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jay-babu/mason-null-ls.nvim',

    -- ui
    'j-hui/fidget.nvim',
    'glepnir/lspsaga.nvim',
    'folke/trouble.nvim',
    'folke/lsp-colors.nvim',

    -- fold
    {
      'kevinhwang91/nvim-ufo',
      'kevinhwang91/promise-async',
    },

    -- lsp addon
    'jose-elias-alvarez/typescript.nvim',
    'b0o/schemastore.nvim',
  },

  config = function()
    local capabilities = require('plugins.lsp_settings.capabilities').capabilities
    local on_attach = require('plugins.lsp_settings.on_attach').on_attach
    local servers = require('plugins.lsp_settings.servers').servers
    local typescript = require 'typescript'

    local mason = require 'mason'
    local mason_lspconfig = require 'mason-lspconfig'
    local null_ls = require 'null-ls'
    local mason_null_ls = require 'mason-null-ls'

    local fidget = require 'fidget'
    local trouble = require 'trouble'
    local lspsaga = require 'lspsaga'
    local ufo = require 'ufo'

    -- fidget
    fidget.setup()

    -- trouble
    trouble.setup { position = 'bottom' }

    -- lspsaga
    lspsaga.setup {
      symbol_in_winbar = {
        color_mode = false,
      },
      ui = {
        theme = 'round',
        title = true,
        border = 'rounded',
        winblend = 0,
      },
      definition = {
        edit = '<CR>',
      },
      scroll_preview = { scroll_down = '<C-d>', scroll_up = '<C-u>' },
      code_action = {
        num_shortcut = true,
        keys = {
          quit = '<Esc>',
          exec = '<CR>',
        },
      },
      rename = {
        quit = '<Esc>',
        exec = '<CR>',
        mark = 'x',
        confirm = '<CR>',
        in_select = true,
      },
      lightbulb = {
        enable = false,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
      },
    }

    -- ufo
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.cmd [[
      augroup _fold_column
        autocmd!
        hi FoldColumn guibg=NONE
      augroup END
    ]]

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    ufo.setup {}

    -- mason
    mason.setup {}

    -- mason_lspconfig
    mason_lspconfig.setup { ensure_installed = vim.tbl_keys(servers) }
    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end,
    }
    typescript.setup {
      server = {
        capabilities = capabilities,
        on_attach = on_attach,
      },
    }

    -- null_ls
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
    null_ls.setup {
      sources = {
        formatting.stylua,
        formatting.prettier,
        formatting.alejandra,
        diagnostics.eslint_d.with {
          condition = function(utils)
            return utils.root_has_file '.eslintrc.js'
          end,
        },
      },
      on_attach = function(current_client, bufnr) -- configure format on save
        if current_client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == 'null-ls'
                end,
                bufnr = bufnr,
              }
            end,
          })
        end
      end,
    }

    -- mason_null_ls
    mason_null_ls.setup {
      ensure_installed = nil,
      automatic_installation = true,
      automatic_setup = false,
    }
  end,
}
