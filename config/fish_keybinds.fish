# ALT+Z = Unsuspend job (equivalent to "fg" command)
bind \cz 'fg 2>/dev/null; commandline -f repaint'

# ALT+C = Cancel command and clear
bind \cc 'commandline ""'

# ALT + / = Forward one word to the right
bind \c_ forward-word

# ALT+R = Select history
bind \cr fzf_select_history

# ALT+O = Open file
bind \co fzf_open_file

# ALT+F = Change directory
bind \cf fzf_change_directory

# ALT+U = Change directory up
bind \cu fzf_change_directory_up

# ALT+G = Jump to repository
bind \cg fzf_jump_to_repository
