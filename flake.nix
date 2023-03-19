{
  description = "arifvn's nix system configurations";

  inputs = {
    # Package sets
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-stable.url = "github:NixOS/nixpkgs/nixos-22.11";

    # Environment/system management
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.inputs.utils.follows = "flake-utils";

    # Flake utilities
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";

    # Android Development
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
    android-nixpkgs.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Utilities
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    # NixGL
    nixgl.url = "github:guibou/nixGL";

    # rust-overlay
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = {
    self,
    darwin,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    inherit
      (inputs.nixpkgs-unstable.lib)
      attrValues
      makeOverridable
      singleton
      optionalAttrs
      ;

    # Default `home-manager`s config specification version.
    homeManagerStateVersion = "23.05";

    # Default configuration for `nixpkgs`.
    defaultNixpkgs = {
      config = {allowUnfree = true;};
      overlays =
        attrValues self.overlays
        ++ singleton (inputs.android-nixpkgs.overlays.default)
        ++ singleton (inputs.rust-overlay.overlays.default)
        ++ singleton (inputs.nixgl.overlays.default);
    };

    # Default user information.
    defaultPrimaryUser = rec {
      username = "arifvn";
      fullName = "Maftukhatul Arifin";
      email = "maftukhatularifin13@gmail.com";
      repoDirectory = "/Volumes/ssd/repo";
      nixConfigDirectory = "${repoDirectory}/github.com/${username}/nixfiles";
    };
  in
    {
      # Add some additional functions to `lib`. -------------------------------------------------

      lib = inputs.nixpkgs-unstable.lib.extend (_: _: {
        mkDarwinSystem = import ./lib/mkDarwinSystem.nix inputs;
      });

      # Overlays --------------------------------------------------------------------------------

      overlays = {
        # Overlays that add different versions `nixpkgs` into package set
        pkgs-master = _: prev: {
          pkgs-master = import inputs.nixpkgs-master {
            inherit (prev.stdenv) system;
            inherit (defaultNixpkgs) config;
          };
        };
        pkgs-stable = _: prev: {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv) system;
            inherit (defaultNixpkgs) config;
          };
        };
        pkgs-unstable = _: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (defaultNixpkgs) config;
          };
        };
        # Add access to x86 packages system is running Apple Silicon
        apple-silicon = _: prev:
          optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            pkgs-x86 = import inputs.nixpkgs-unstable {
              system = "x86_64-darwin";
              inherit (defaultNixpkgs) config;
            };
          };

        # Overlay that adds various additional utility functions to `vimUtils`
        vimUtils = import ./overlays/vimUtils.nix;

        # Overlay that adds some additional Neovim plugins
        vimPlugins = final: prev: let
          inherit (self.overlays.pkgs-unstable final prev) pkgs-unstable;
          inherit (pkgs-unstable) fetchFromGitHub;
          inherit (self.overlays.vimUtils final prev) vimUtils;
        in {
          vimPlugins = prev.vimPlugins.extend (_: _:
            # Useful for testing/using Vim plugins that aren't in `nixpkgs`.
              vimUtils.buildVimPluginsFromFlakeInputs inputs [
                # Add flake input names here for a Vim plugin repos
              ]
              // {
                # Other Vim plugins
                lazy-nvim = vimUtils.buildVimPluginFrom2Nix {
                  pname = "lazy.nvim";
                  version = "2023-01-15";
                  src = fetchFromGitHub {
                    owner = "folke";
                    repo = "lazy.nvim";
                    rev = "984008f7ae17c1a8009d9e2f6dc007e13b90a744";
                    sha256 = "19hqm6k9qr5ghi6v6brxr410bwyi01mqnhcq071h8bibdi4f66cg";
                  };
                  meta.homepage = "https://github.com/folke/lazy.nvim";
                };

                git-conflict-nvim = vimUtils.buildVimPluginFrom2Nix {
                  pname = "git-conflict.nvim";
                  version = "2022-12-31";
                  src = fetchFromGitHub {
                    owner = "akinsho";
                    repo = "git-conflict.nvim";
                    rev = "cbefa7075b67903ca27f6eefdc9c1bf0c4881017";
                    sha256 = "1pli57rl2sglmz2ibbnjf5dxrv5a0nxk8kqqkq1b0drc30fk9aqi";
                  };
                  meta.homepage = "https://github.com/akinsho/git-conflict.nvim";
                };

                codeium-vim = vimUtils.buildVimPluginFrom2Nix {
                  pname = "codeium-vim";
                  version = "2023-02-08";
                  src = fetchFromGitHub {
                    owner = "Exafunction";
                    repo = "codeium.vim";
                    rev = "78382694eb15e1818ec6ff9ccd0389f63661b56f";
                    sha256 = "1b4lf0s8x3qqvpmyzz0a7j3ynvlzx8sx621dqbf8l3vl7nfkc4gy";
                  };
                  meta.homepage = "https://github.com/Exafunction/codeium.vim";
                };
              });
        };
      };

      # Modules ---------------------------------------------------------------------------------

      darwinModules = {
        arifvn-system-nix = import ./darwin/system-nix.nix;
        arifvn-homebrew = import ./darwin/homebrew.nix;
        arifvn-system-settings = import ./darwin/system-settings.nix;
        arifvn-system-networking = import ./darwin/system-networking.nix;
        arifvn-system-fonts = import ./darwin/system-fonts.nix;
        arifvn-system-packages = import ./darwin/system-packages.nix;
        arifvn-system-shell = import ./darwin/system-shell.nix;

        # Additional modules
        users-primaryUser = import ./modules/darwin/users.nix;
      };

      homeManagerModules = {
        arifvn-config-files = import ./home/config-files.nix;
        arifvn-git = import ./home/git.nix;
        arifvn-kitty = import ./home/kitty.nix;
        arifvn-neovim = import ./home/neovim.nix;
        arifvn-packages = import ./home/packages.nix;
        arifvn-shell-aliases = import ./home/shell-aliases.nix;
        arifvn-shell-prompt = import ./home/shell-prompt.nix;
        arifvn-shell = import ./home/shell.nix;
        arifvn-tmux = import ./home/tmux.nix;

        # Additional modules
        home-user-info = {lib, ...}: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser {
              inherit lib;
            })
            .options
            .users
            .primaryUser;
        };
      };

      # System Configuation ---------------------------------------------------------------------
      darwinConfigurations = {
        # Minimal macOS configurations to bootstrap systems
        bootstrap-x86 = makeOverridable darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          modules = [./darwin/system-nix.nix ./darwin/system-shell.nix {nixpkgs = defaultNixpkgs;}];
        };
        bootstrap-arm = self.darwinConfigurations.bootstrap-x86.override {
          system = "aarch64-darwin";
        };

        # MacPro x86_64-darwin
        "${defaultPrimaryUser.username}" = makeOverridable self.lib.mkDarwinSystem (defaultPrimaryUser
          // {
            modules =
              attrValues self.darwinModules
              ++ singleton {
                nixpkgs = defaultNixpkgs;
                networking.computerName = "${defaultPrimaryUser.username}’s 💻";
                networking.hostName = "${defaultPrimaryUser.username}-MacPro";

                # To display a list of all the network services
                # on the server's hardware ports, use networksetup -listallnetworkservices.
                networking.knownNetworkServices = ["Ethernet" "802.11n NIC"];
                nix.registry.my.flake = inputs.self;
              };
            inherit homeManagerStateVersion;
            homeModules = attrValues self.homeManagerModules;
          });
      };

      # Home Configurations -----------------------------------------------------------------------
      homeConfigurations."${defaultPrimaryUser.username}" = home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs-unstable (defaultNixpkgs // {system = "x86_64-linux";});
        modules =
          attrValues self.homeManagerModules
          ++ singleton ({config, ...}: {
            programs.home-manager.enable = true;
            home.username = config.home.user-info.username;
            home.homeDirectory = "/home/${config.home.username}";
            home.stateVersion = homeManagerStateVersion;
            home.user-info =
              defaultPrimaryUser
              // {
                nixConfigDirectory = "${config.home.homeDirectory}/nixfiles";
                repoDirectory = "${config.home.homeDirectory}/repo";
              };
          });
      };
    }
    // flake-utils.lib.eachDefaultSystem (system: rec {
      legacyPackages = import inputs.nixpkgs-unstable (defaultNixpkgs // {inherit system;});

      # Checks ---------------------------------------------------------------------
      # e.g., run `nix flake check` in $HOME/.config/nixpkgs.

      checks = {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          # you can enable more hooks here {https://github.com/cachix/pre-commit-hooks.nix/blob/a4548c09eac4afb592ab2614f4a150120b29584c/modules/hooks.nix}
          hooks = {
            actionlint.enable = true;
            shellcheck.enable = true;
            stylua.enable = true;
            # TODO https://github.com/cachix/pre-commit-hooks.nix/issues/196
            # make override and pass configuration
            luacheck.enable = false;

            # .nix related
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
          };
        };
      };

      # Development shells ---------------------------------------------------------------------
      # Shell environments for development
      # With `nix.registry.my.flake = inputs.self`, development shells can be created by running,
      # e.g., `nix develop my#node`.
      # https://daiderd.com/nix-darwin/manual/index.html#opt-nix.registry._name_.flake
      devShells = let
        pkgs = self.legacyPackages.${system};
      in
        import ./devShells/devShells.nix {
          inherit pkgs;
          inherit (inputs.nixpkgs-unstable) lib;
        }
        // {
          # `nix develop my`.
          default = pkgs.mkShell {
            name = "arifvn_devshells_default";
            shellHook = '''' + checks.pre-commit-check.shellHook;
            buildInputs = checks.pre-commit-check.buildInputs or [];
            packages = checks.pre-commit-check.packages or [];
          };
        };
    });
}
