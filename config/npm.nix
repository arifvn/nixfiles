{ pkgs, lib, ... }: {
  home.file.".npmrc".text = ''
    prefix=~/.node_modules
  '';
}
