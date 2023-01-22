set fish_greeting

set -gx PATH $HOME/.node-modules/bin/ $PATH

set -gx LANG en_US.UTF-8
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER vivaldi

set -gx FZF_DEFAULT_OPTS "--pointer='➜' --layout=reverse --cycle --color=bg+:#1f2329,bg:#1f2329,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
