local opt = vim.opt

opt.encoding = 'utf-8' -- set default encoding to UTF-8
opt.number = true -- shows absolute line number
opt.relativenumber = false -- show relative line numbers
opt.cursorline = true -- highlight the current cursor line

opt.title = true
opt.hlsearch = true -- disable highlight search
opt.showcmd = true -- show partial cmd
opt.shell = 'fish' -- default cmd shell
opt.completeopt = 'menuone,menu,noselect' -- better completion
opt.updatetime = 250 -- default cmd shell

opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- opt.ch = 0 -- command line and status line at one row
opt.mouse = 'c' -- disable mouse
opt.showmode = false -- disable default statusline (we'll be using plugin to show it instead)

-- windblend
opt.winblend = 0
opt.wildoptions = 'pum'
opt.pumblend = 5
opt.pumheight = 10 -- pop up menu height

-- if a file has been changed by another editor
-- re-read it again inside nvim
opt.autoread = true

opt.linebreak = true -- Stop words being broken on wrap
opt.wrap = false -- disable line wrapping
opt.hidden = true -- hide unused buffer

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true -- enable persistent undo

opt.scrolloff = 12
opt.sidescrolloff = 12

opt.termguicolors = true -- make sure gui colors work properly
opt.background = 'dark' -- colorschemes that can be light or dark will be made dark
opt.signcolumn = 'yes' -- show sign column so that text doesn't shift

-- allow backspace on indent,
-- end of line or insert mode start position
opt.backspace = 'indent,eol,start'
opt.clipboard:append 'unnamedplus' -- use system clipboard as default register

opt.splitright = true
opt.splitbelow = true

-- go to previous/next line with h,l
-- when cursor reaches end/beginning of line
opt.whichwrap:append '<>[]hl'

opt.iskeyword:append '-' -- consider string-string as whole word

-- s don't give "search hit BOTTOM, continuing at TOP" or "search
-- I	don't give the intro message when starting Vim |:intro|.
-- c	don't give |ins-completion-menu| messages.
opt.shortmess:append 'sIc'

-- end of buffer character with space, default '~'
-- hide vertical line
-- fold character
opt.fillchars = {
  eob = ' ',
  vert = ' ',
  fold = ' ',
  foldopen = '',
  foldsep = ' ',
  foldclose = '',
}
