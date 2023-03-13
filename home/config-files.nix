{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in
  lib.mkMerge [
    {
      home.file.".npmrc".text = ''
        prefix=~/.npm
      '';
      home.file.".ideavimrc".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/android-studio/ideavimrc";
    }

    (lib.mkIf pkgs.stdenv.isDarwin {
      xdg.configFile."karabiner/karabiner.json".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/karabiner/karabiner.json";
    })
  ]
