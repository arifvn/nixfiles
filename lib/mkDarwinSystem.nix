inputs: {
  username,
  fullName,
  email,
  nixConfigDirectory, # directory on the system where this flake is located
  repoDirectory, # directory uses for `ghq` package
  system ? "x86_64-darwin",
  modules ? [], # `nix-darwin` modules to include
  extraModules ? [], # Additional `nix-darwin` modules to include, useful when reusing a configuration with `lib.makeOverridable`.
  homeManagerStateVersion, # Value for `home-manager`'s `home.stateVersion` option.
  homeModules ? [], # `home-manager` modules to include
  extraHomeModules ? [], # Additional `home-manager` modules to include, useful when reusing a configuration with `lib.makeOverridable`.
}:
inputs.darwin.lib.darwinSystem {
  inherit system;
  modules =
    modules
    ++ extraModules
    ++ [
      inputs.home-manager.darwinModules.home-manager
      ({config, ...}: {
        users.primaryUser = {
          inherit username fullName email nixConfigDirectory repoDirectory;
        };

        # Support legacy workflows that use `<nixpkgs>` etc.
        nix.nixPath.nixpkgs = "${inputs.nixpkgs-unstable}";

        # `home-manager` config
        users.users.${username}.home = "/Users/${username}";
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${username} = {
          imports = homeModules ++ extraHomeModules;
          home.stateVersion = homeManagerStateVersion;
          home.user-info = config.users.primaryUser;
        };
      })
    ];
}
