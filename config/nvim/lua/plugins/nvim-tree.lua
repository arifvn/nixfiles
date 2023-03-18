return {
  'nvim-tree/nvim-tree.lua',

  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'NvimTree' },
  },

  config = function()
    -- auto close nvim when nvim-tree is the last window
    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
      pattern = 'NvimTree_*',
      callback = function()
        local layout = vim.api.nvim_call_function('winlayout', {})
        if
          layout[1] == 'leaf'
          and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), 'filetype') == 'NvimTree'
          and layout[3] == nil
        then
          vim.cmd 'confirm quit'
        end
      end,
    })

    -- override colors
    vim.cmd [[
      augroup _nvimtree_color_override
        autocmd!
        highlight NvimTreeNormal guibg=NONE
        highlight NvimTreeEndOfBuffer guibg=NONE
        highlight NvimTreeIndentMarker guifg=NONE
      augroup END
    ]]

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('nvim-tree').setup {
      update_focused_file = {
        enable = false,
        update_cwd = true,
      },
      renderer = {
        group_empty = false,
        indent_markers = {
          enable = true,
          icons = { corner = '', edge = '', item = '', bottom = '─', none = ' ' },
        },
        highlight_opened_files = 'name',
        icons = {
          git_placement = 'after',
          show = {
            git = true,
          },
          glyphs = {
            git = {
              unstaged = '◌',
              staged = '✓',
              unmerged = '',
              renamed = '➜',
              untracked = '★',
              deleted = '',
              ignored = '○',
            },
          },
        },
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      view = {
        width = 28,
      },
      filters = { custom = { '^.git$' } },
    }
  end,
}
