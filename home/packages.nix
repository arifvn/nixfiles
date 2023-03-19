{
  pkgs,
  lib,
  ...
}:
lib.mkMerge [
  {
    programs.bat = {
      enable = true;
      config.style = "plain";
      config.theme = "OneHalfDark";
    };

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    home.packages = with pkgs; [
      # common
      coreutils
      curl
      wget
      tree
      gnupg
      ack
      asciinema

      # Productivity
      fzf
      ghq
      exa
      fd
      du-dust
      ripgrep
      ffmpeg
      imagemagick
      yt-dlp
      tealdeer
      thefuck
      gh
      duf
      vim

      # Development
      babelfish
      gcc
      jq
      gnumake
      nodejs
      google-cloud-sdk
      yarn
      python3

      # Nix
      cachix
      comma
      alejandra
      statix
      nix-output-monitor
    ];
  }

  (lib.mkIf pkgs.stdenv.isDarwin {
    home.packages = with pkgs; [
      mas
      xcode-install
      m-cli
      cocoapods
    ];
  })

  (lib.mkIf pkgs.stdenv.isLinux {
    home.packages = with pkgs; [
      android-studio
      vivaldi
      postman
      vscode
      xclip
      vlc

      # fonts
      recursive
      (nerdfonts.override {
        fonts = ["FiraCode" "CascadiaCode"];
      })
    ];

    # fonts will be shown in fontconfig
    fonts.fontconfig.enable = true;

    # apps will be listed on launcher
    targets.genericLinux.enable = true;
  })
]
