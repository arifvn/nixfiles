{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  brewEnabled = config.homebrew.enable;
in {
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  system.activationScripts.preUserActivation.text = mkIf brewEnabled ''
    if [ ! -f ${config.homebrew.brewPrefix}/brew ]; then
      ${pkgs.bash}/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
  '';

  homebrew.enable = true;

  # Whether to enable Homebrew to auto-update itself and all formulae during nix-darwin system activation.
  homebrew.onActivation.autoUpdate = false;

  homebrew.onActivation.upgrade = false;
  homebrew.onActivation.cleanup = "zap";

  # Whether to enable Homebrew to auto-update itself and all formulae when you manually invoke commands like brew install, brew upgrade etc.
  homebrew.global.autoUpdate = false;

  homebrew.global.brewfile = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "nrlquaker/createzap"
  ];

  homebrew.masApps = {
    Guidance = 412759995;
    Vimari = 1480933944;
    Xcode = 497799835;
  };

  homebrew.casks = [
    "android-studio"
    "kitty"
    "vivaldi"
    "postman"
    "visual-studio-code"
    "zoom"
    "alt-tab"
    "raycast"
    "lulu"
    "qbittorrent"
    "sequel-pro"
    "the-unarchiver"
    "foxitreader"
    "karabiner-elements"
    "balenaetcher"
    "vlc"
    "intellij-idea-ce"

    # "iriunwebcam"
    # "istat-menus"
    # "cleanmymac"
    # "microsoft-office"
    # "tuxera-ntfs"
  ];
}
