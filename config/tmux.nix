{ pkgs, lib, ... }:

{
  programs.tmux.enable = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.disableConfirmationPrompt = true;
  programs.tmux.keyMode = "vi";
  programs.tmux.newSession = true;
  programs.tmux.prefix = "C-a";
  programs.tmux.reverseSplit = true;
  programs.tmux.shell = "${pkgs.fish}/bin/fish";
  programs.tmux.shortcut = "a";
  programs.tmux.customPaneNavigationAndResize = true;

  programs.tmux.extraConfig = ''
    set -g allow-rename off
    set -ga terminal-overrides ",xterm-256color:RGB"
    set -g default-terminal "tmux-256color"
    set -g status-position bottom
    set -gs escape-time 10
    set -g focus-events on

    # Status line
    set -g status-style bg=default
    set -g status-fg colour178
    set -g status-right " "
    set -g status-left " "
    set -g status-left-length 90
    set -g status-right-length 90
    set -g status-justify absolute-centre
    set -g window-status-current-format "●"
    set -g window-status-format "○"

    # Disable confirmation dialog
    bind-key & kill-window
    bind-key x kill-pane
    
    # Split panes using v and h
    bind v split-window -h
    bind h split-window -v
    unbind '"'
    unbind %
    
    # Resizing pane
    bind -r C-k resize-pane -U 5
    bind -r C-j resize-pane -D 5
    bind -r C-h resize-pane -L 5
    bind -r C-l resize-pane -R 5
  '';

  programs.tmux.plugins = with pkgs; [
    {
      plugin = tmuxPlugins.resurrect;
    }
    {
      plugin = tmuxPlugins.continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
        set -g @continuum-save-interval '60' # minutes
      '';
    }
    {
      plugin = tmuxPlugins.vim-tmux-navigator;
      extraConfig = ''
        # Smart pane switching with awareness of Vim splits.
        # See: https://github.com/christoomey/vim-tmux-navigator
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$'"
        bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
        bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
        bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
        bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
        tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
        if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
        if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
            "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

        bind-key -T copy-mode-vi 'C-h' select-pane -L
        bind-key -T copy-mode-vi 'C-j' select-pane -D
        bind-key -T copy-mode-vi 'C-k' select-pane -U
        bind-key -T copy-mode-vi 'C-l' select-pane -R
        bind-key -T copy-mode-vi 'C-\' select-pane -l
      '';
    }
  ];

  home.packages = with pkgs;
    lib.optionals stdenv.isDarwin [ reattach-to-user-namespace ];
}
