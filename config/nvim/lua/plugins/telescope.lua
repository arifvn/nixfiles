return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  keys = {
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Telescope recent files' },
    { '<leader>fo', '<cmd>Telescope find_files<cr>', desc = 'Telescope find files' },
    { '<leader>ff', '<cmd>Telescope find_files hidden=true<cr>', desc = 'Telescope find files hidden' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Telescope live grep' },
    { '<leader>fc', '<cmd>Telescope grep_string<cr>', desc = 'Telescope grep current word' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Telescope buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Telescope help' },
    { '<leader>fd', '<cmd>Telescope diagnostics<cr>', desc = 'Telescope diagnostics' },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Telescope keymaps' },
  },
  config = function()
    vim.cmd [[
      augroup telescope_color_override
        autocmd!
        hi TelescopePromptBorder guifg=#535965
        hi TelescopePreviewBorder guifg=#535965
        hi TelescopeResultsBorder guifg=#535965
      augroup END
    ]]

    local actions = require 'telescope.actions'
    local no_preview = {
      previewer = false,
      layout_config = {
        width = 0.5,
        height = 0.80,
        preview_cutoff = 0,
      },
    }

    local help_preview = {
      layout_strategy = 'vertical',
      layout_config = {
        vertical = {
          prompt_position = 'top',
          mirror = true,
        },
        width = 0.87,
        height = 0.90,
        preview_cutoff = 0,
      },
    }

    require('telescope').setup {
      pickers = {
        find_files = no_preview,
        buffers = no_preview,
        oldfiles = no_preview,
        help_tags = help_preview,
      },
      defaults = {
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<Esc>'] = actions.close,
          },
        },
        prompt_prefix = ' ',
        selection_caret = ' ',
        path_display = { 'truncate' },
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 0,
        },
      },
    }

    require('telescope').load_extension 'fzf'
  end,
}
