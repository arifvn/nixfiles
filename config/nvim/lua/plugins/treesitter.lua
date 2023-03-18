return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  event = 'BufReadPost',

  keys = {
    { '<c-space>', desc = 'Increment selection' },
    { '<bs>', desc = 'Schrink selection', mode = 'x' },
  },

  build = function()
    local ts_update = require('nvim-treesitter.install').update { with_sync = true }
    ts_update()
  end,

  config = function()
    require('nvim-treesitter.configs').setup {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python', 'css' } },
      context_commentstring = { enable = true, enable_autocmd = false },
      autotag = { enable = true },
      autopairs = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = '<nop>',
          node_decremental = '<bs>',
        },
      },
      ensure_installed = {
        'javascript',
        'typescript',
        'css',
        'html',
        'markdown',
        'markdown_inline',
        'tsx',
        'toml',
        'yaml',
        'svelte',
        'graphql',
        'json',
        'php',
        'fish',
        'lua',
        'python',
        'help',
        'nix',
        'dockerfile',
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }
  end,
}
