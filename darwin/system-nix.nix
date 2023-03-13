{
  config,
  lib,
  pkgs,
  ...
}: {
  # Nix configuration ------------------------------------------------------------------------------

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix = {
    configureBuildUsers = true;

    settings = {
      auto-optimise-store = true;

      substituters = [
        "https://nix-community.cachix.org"
        "https://arifvn.cachix.org/"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "arifvn.cachix.org-1:S3JSeJZ6u+2S/lO3ahWxxLr5mMYTWZuStrfKA1KxDvs="
      ];

      trusted-users = [
        "@admin"
        "arifvn"
      ];
    };

    # enable garbage-collection on weekly and delete-older-than 30 day
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    # this is configuration for /etc/nix/nix.conf
    # so it will be generated in /etc/nix/nix.conf
    extraOptions =
      ''
        experimental-features = nix-command flakes
        keep-outputs = true
        keep-derivations = true
      ''
      + lib.optionalString (pkgs.system == "aarch64-darwin") ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
  };
}
