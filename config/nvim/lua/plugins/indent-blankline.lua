return {
  'lukas-reineke/indent-blankline.nvim',

  config = function()
    require('indent_blankline').setup {
      show_current_context = true,
      char = '▏',
      show_trailing_blankline_indent = false,
    }

    vim.cmd [[
      highlight IndentBlanklineContextChar guifg=#535965 gui=nocombine
    ]]
  end,
}
