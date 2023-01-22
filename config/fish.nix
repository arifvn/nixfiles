{ pkgs, lib, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      ${lib.fileContents ./fish_colors.fish} 
      ${lib.fileContents ./fish_vars.fish} 
      ${lib.fileContents ./fish_functions.fish} 
      ${lib.fileContents ./fish_keybinds.fish} 
    '';

    shellAbbrs = import ./fish_abbrs.nix { };
    shellAliases = import ./fish_aliases.nix { };

    plugins = import ./fish_plugins.nix { inherit pkgs; };
  };
}
