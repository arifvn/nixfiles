return {
  'mrjones2014/smart-splits.nvim',

  config = function()
    local smartsplits = require 'smart-splits'

    return {
      { '<A-j>', smartsplits.resize_down, desc = 'Window resize down' },
      { '<A-l>', smartsplits.resize_right, desc = 'Window resize right' },
      { '<A-h>', smartsplits.resize_left, desc = 'Window resize left' },
      { '<A-k>', smartsplits.resize_up, desc = 'Window resize up' },
    }
  end,
}
