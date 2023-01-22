{ config, pkgs, lib, ... }: {

  home = {
    username = "arifvn";
    homeDirectory = "/home/arifvn";
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  # fonts will be shown on fontconfig
  fonts.fontconfig.enable = true;

  # apps will be listed on launcher
  targets.genericLinux.enable = true;

  home.packages = with pkgs;
    [
      # Shell
      fish
      starship

      # Productivity
      neovim
      git
      tmux
      bat
      fzf
      ghq
      fd
      exa
      ripgrep
      tree
      # du-dust
      # tldr
      # duf
      # broot
      # fzy
      # jq

      # Development
      gnumake
      gcc
      nodejs-19_x
      # ngrok
      # python3
      # jdk

      # Nix
      # nixfmt
      # comma

      # Misc
      # youtube-dl
      # wget
      # curl
      xclip

    ] ++ lib.optionals stdenv.isDarwin [
      xcode-install
      cocoapods
      mas
      rectangle
    ];

  imports = [
    ./config/git.nix
    ./config/fish.nix
    ./config/starship.nix
    ./config/tmux.nix
    ./config/bat.nix
    ./config/fonts.nix
    ./config/gui.nix
    ./config/npm.nix
    # ./config/neovim.nix
  ];
}
