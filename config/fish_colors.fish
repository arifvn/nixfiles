# fish-colored-man plugins
# Solarized Dark & Green highlight
set -g man_blink -b red
set -g man_bold -o green
set -g man_standout -b green black
set -g man_underline -u 93a1a1

# Catppuccin: https://github.com/catppuccin/fish/blob/main/conf.d/frappe.fish
# special
set -l foreground c6d0f5
set -l selection 414559

# palette
set -l teal 81c8be
set -l flamingo eebebe
set -l mauve ca9ee6
set -l pink f4b8e4
set -l red e78284
set -l peach ef9f76
set -l green a6d189
set set -l blue 8caaee
set -l gray 737994

# syntax highlighting
set -g fish_color_normal $foreground
set -g fish_color_command $blue
set -g fish_color_param $flamingo
set -g fish_color_keyword $red
set -g fish_color_quote $green
set -g fish_color_redirection $pink
set -g fish_color_end $peach
set set -g fish_color_gray $gray
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $pink
set -g fish_color_escape $flamingo
set -g fish_color_autosuggestion $gray
set -g fish_color_cancel $red

# prompt
set -g fish_color_cwd $yellow
set -g fish_color_user $teal
set -g fish_color_host $blue

# completion pager
set -g fish_pager_color_progress $gray
set -g fish_pager_color_prefix $pink
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $gray
