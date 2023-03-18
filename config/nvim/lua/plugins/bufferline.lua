return {
  'akinsho/bufferline.nvim',
  version = 'v3.*',

  lazy = false,

  dependencies = {
    'moll/vim-bbye',
  },

  keys = {
    { '<leader>x', '<cmd>Bwipeout<CR>', desc = 'Close buffer' },
    { '<S-j>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Buffer prev' },
    { '<S-k>', '<cmd>BufferLineCycleNext<CR>', desc = 'Buffer next' },
  },

  config = function()
    vim.cmd [[
      augroup nvimtree_color_override
        autocmd!
        hi BufferLineFill guibg=#282c34
        hi BufferLineOffsetSeparator guibg=#1f2329 guifg=#282c34
      augroup END
    ]]

    require('bufferline').setup {
      options = {
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        separator_style = 'thin',
        modified_icon = '●',
        buffer_close_icon = '',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 15,
        max_prefix_length = 6,
        diagnostics = 'nvim_lsp',
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        persist_buffer_sort = true,
        enforce_regular_tabs = true,
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and '●' or ''
          return ' ' .. icon .. count
        end,
      },
    }
  end,
}
