return {
  'hrsh7th/nvim-cmp',

  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-nvim-lua',

    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',

    'onsails/lspkind.nvim',
  },

  event = { 'InsertEnter' },

  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()

    local luasnip = require 'luasnip'
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'

    local select_opts = { behavior = cmp.SelectBehavior.Select }
    local winhighlight = {
      winhighlight = 'Normal:Normal,FloatBorder:Comment,CursorLine:PmenuSel',
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(winhighlight),
        documentation = cmp.config.window.bordered(winhighlight),
      },
      experimental = { ghost_text = true },
      formatting = {
        format = lspkind.cmp_format {
          preset = 'codicons',
          mode = 'symbol_text',
          maxwidth = 20,
          ellipsis_char = '... ',
          menu = {
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            buffer = '[Buffer]',
            path = '[Path]',
            nvim_lua = '[Lua]',
            emoji = '[Emoji]',
          },
        },
      },
      sources = cmp.config.sources {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'emoji' },
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },

        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Space>'] = cmp.mapping.confirm(),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
    }
  end,
}
