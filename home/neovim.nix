{config, ...}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (config.home.user-info) nixConfigDirectory;
in {
  programs.neovim.enable = true;
  xdg.configFile."nvim/lua".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/nvim/lua";
  xdg.configFile."nvim/.stylua.toml".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/nvim/.stylua.toml";
  xdg.configFile."nvim/init.lua".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/nvim/init.lua";
  xdg.configFile."nvim/lazy-lock.json".source = mkOutOfStoreSymlink "${nixConfigDirectory}/config/nvim/lazy-lock.json";
}
