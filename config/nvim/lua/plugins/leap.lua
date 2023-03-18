return {
  'ggandor/leap.nvim',

  dependencies = {
    'tpope/vim-repeat',
  },

  keys = {
    { 's', desc = 'Leap forward', mode = 'n' },
    { 'S', desc = 'Leap backward', mode = 'n' },
  },

  config = function()
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    require('leap').add_default_mappings()
  end,
}
