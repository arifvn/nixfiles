return {
  'navarasu/onedark.nvim',
  lazy = false,
  priority = 1000,

  config = function()
    require('onedark').setup {
      style = 'darker',
      transparent = false,
      term_colors = true,
      ending_tildes = false,
      cmp_itemkind_reverse = false,
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'italic',
        strings = 'none',
        variables = 'none',
      },
      lualine = {
        transparent = false,
      },
      colors = {},
      highlights = {
        Visual = { bg = '#5c6370', fg = '#e6efff' },
      },
      diagnostics = {
        darker = true,
        undercurl = true,
        background = true,
      },
    }
    require('onedark').load()
  end,
}
