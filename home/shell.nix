{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.home.user-info) nixConfigDirectory username repoDirectory;
  androidHome =
    if pkgs.stdenv.isDarwin
    then "/Users/${username}/Library/Android/sdk"
    else "$HOME/Android/Sdk";
  androidTools = "${androidHome}/tools/";
  androidPlatformTools = "${androidHome}/platform-tools/";
in {
  home = with pkgs; {
    sessionVariables = {
      LANG = "en_US.UTF-8";
      EDITOR = "${neovim}/bin/nvim";
      FZF_DEFAULT_OPTS = "--pointer='➜' --layout=reverse --cycle --color=bg+:#1f2329,bg:#1f2329,spinner:#98c379,hl:#659542 --color=fg:#D9E0EE,header:#659542,info:#DDB6F2,pointer:#659542 --color=marker:#659542,fg+:#e06c75,prompt:#DDB6F2,hl+:#659542";
      GHQ_ROOT = "${repoDirectory}";
    };
    packages = with fishPlugins; [
      done
      foreign-env
    ];
  };

  programs = {
    zoxide.enable = true;
    dircolors.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        ${pkgs.thefuck}/bin/thefuck --alias | source

        set -gx PATH ${androidTools} $PATH
        set -gx PATH ${androidPlatformTools} $PATH
        set -gx PATH $HOME/.yarn/bin $PATH
        set -gx PATH $HOME/.npm/bin $PATH

        # Fish color
        set -U fish_color_command 6CB6EB --bold
        set -U fish_color_redirection DEB974
        set -U fish_color_operator DEB974
        set -U fish_color_end C071D8 --bold
        set -U fish_color_error EC7279 --bold
        set -U fish_color_param 6CB6EB
        set fish_greeting

        # Fish keybinding

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

        # ALT+V = Convert github https url to ssh
        bind \cv paste_github_url_from_https_to_ssh
      '';

      functions = {
        fzf_open_file.body = ''
          begin
            # add default directory to search for e.g.
            # ${pkgs.fd}/bin/fd --hidden --type file --exclude .git --absolute-path . $HOME/Downloads

            # list files under current directory except .git
            ${pkgs.fd}/bin/fd --hidden --type file --exclude .git --absolute-path
          end | ${pkgs.fzf}/bin/fzf --prompt="OpenFile>" --query "$argv " | read fileName

          if [ $fileName ]
            ${config.home.sessionVariables.EDITOR} $fileName
          else
            commandline ""
          end
        '';
        fzf_select_history.body = let
          clipboard =
            if pkgs.stdenv.isLinux
            then pkgs.xclip + "/bin/xclip -selection clipboard"
            else "pbcopy";
        in ''
          if test (count $argv) = 0
            history | ${pkgs.fzf}/bin/fzf --prompt="History>" | read foo
          else
            history | ${pkgs.fzf}/bin/fzf --prompt="History>" --query "$argv " | read foo
          end

          if [ $foo ]
            commandline $foo
            echo $foo | ${clipboard}
          else
            commandline ""
          end
        '';
        _fzf_change_directory.body = ''
          if [ (count $argv) ]
            ${pkgs.fzf}/bin/fzf --prompt="ChangeDir>" --query "$argv " | read foo
          else
            ${pkgs.fzf}/bin/fzf --prompt="ChangeDir>" | read foo
          end

          if [ $foo ]
            builtin cd $foo
            commandline -r ""
            commandline -f repaint
          else
            commandline ""
          end
        '';
        fzf_change_directory.body = ''
          begin
            # add custom directories to be listed
            # if test -d $HOME/.dotfiles
            #   echo $HOME/.dotfiles
            # end

            # list current directory except .git
            ${pkgs.fd}/bin/fd --hidden --type directory --exclude .git --absolute-path
          end | _fzf_change_directory $argv
        '';
        _fzf_change_directory_up.body = ''
          if [ (count $argv) ]
            ${pkgs.fzf}/bin/fzf --prompt="ChangeDirUp>" --query "$argv " | read foo
          else
            ${pkgs.fzf}/bin/fzf --prompt="ChangeDirUp>" | read foo
          end

          if [ $foo ]
            builtin cd $foo
            commandline -r ""
            commandline -f repaint
          else
            commandline ""
          end
        '';
        fzf_change_directory_up.body = ''
          begin
            # add custom directories to be listed e.g.
            # echo $HOME/Downloads

            set parent "$(dirname $(pwd))"
            set grandparent "$(dirname $parent)"
            set grandparent1 "$(dirname $grandparent)"
            set grandparent2 "$(dirname $grandparent1)"

            echo $parent
            echo $parent | xargs ${pkgs.fd}/bin/fd --hidden --type directory --max-depth 2 --exclude .git --full-path /
            echo $grandparent2
            echo $grandparent1
            echo $grandparent
          end | _fzf_change_directory_up $argv
        '';
        _fzf_jump_to_repository.body = ''
          if [ (count $argv) ]
            ${pkgs.fzf}/bin/fzf --prompt="JumpToRepo>" --query "$argv " | read foo
          else
            ${pkgs.fzf}/bin/fzf --prompt="JumpToRepo>" | read foo
          end

          if [ $foo ]
            builtin cd $foo
            commandline -r ""
            commandline -f repaint
          else
            commandline ""
          end

        '';
        fzf_jump_to_repository.body = ''
          begin
            # list local repositories with full path
            ${pkgs.ghq}/bin/ghq list -p

          end | _fzf_jump_to_repository $argv
        '';
        paste_github_url_from_https_to_ssh = let
          clipboard =
            if pkgs.stdenv.isLinux
            then pkgs.xclip + "/bin/xclip -o -selection clipboard"
            else "pbpaste";
        in ''
          ${clipboard} | sed 's/https:\/\/github.com\//git@github.com:/' | read foo

          if [ $foo ]
            commandline -i $foo
          else
            commandline ""
          end
        '';
      };

      plugins = with pkgs.fishPlugins; [
        {
          name = "sponge";
          src = pkgs.fetchFromGitHub {
            owner = "meaningful-ooo";
            repo = "sponge";
            rev = "384299545104d5256648cee9d8b117aaa9a6d7be";
            sha256 = "sha256-MdcZUDRtNJdiyo2l9o5ma7nAX84xEJbGFhAVhK+Zm1w=";
          };
        }
        {
          name = "fish-colored-man";
          src = pkgs.fetchFromGitHub {
            owner = "decors";
            repo = "fish-colored-man";
            rev = "1ad8fff696d48c8bf173aa98f9dff39d7916de0e";
            sha256 = "sha256-uoZ4eSFbZlsRfISIkJQp24qPUNqxeD0JbRb/gVdRYlA=";
          };
        }
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
          };
        }
        {
          name = "thefuck";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-thefuck";
            rev = "6c9a926d045dc404a11854a645917b368f78fc4d";
            sha256 = "1n6ibqcgsq1p8lblj334ym2qpdxwiyaahyybvpz93c8c9g4f9ipl";
          };
        }
        {
          name = "puffer-fish";
          src = pkgs.fetchFromGitHub {
            owner = "nickeb96";
            repo = "puffer-fish";
            rev = "fd0a9c95da59512beffddb3df95e64221f894631";
            sha256 = "sha256-aij48yQHeAKCoAD43rGhqW8X/qmEGGkg8B4jSeqjVU0=";
          };
        }
        {
          name = "autopair";
          src = pkgs.fetchFromGitHub {
            owner = "jorgebucaran";
            repo = "autopair.fish";
            rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
            sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
          };
        }
        {
          name = "fish-git-abbr";
          src = pkgs.fetchFromGitHub {
            owner = "lewisacidic";
            repo = "fish-git-abbr";
            rev = "abe95203b7fcb1eaa685bd5b75796b52bb7be884";
            sha256 = "sha256-UP+bk5luk6bNrMzI4eQkt9TzU8dkjEqGoEnlEh4fEK4=";
          };
        }
      ];
    };
  };
}
