{
  config,
  pkgs,
  ...
}: let
  inherit (config.home.user-info) nixConfigDirectory;

  shellAliases = with pkgs;
    lib.mkMerge [
      {
        # Nix
        nclean = "nix-collect-garbage && nix-collect-garbage -d";
        lenv = "nix-env --list-generations";
        senv = "nix-env --switch-generation";
        denv = "nix-env --delete-generations";
        doenv = "denv old";
        renv = "nix-env --rollback";

        # is equivalent to: nix build --recreate-lock-file e.g flakeup home-manager
        flakeup-all = "nix flake update ${nixConfigDirectory}";
        flakeup = "nix flake lock ${nixConfigDirectory} --update-input";
        nb = "nix build";
        ndp = "nix develop";
        nf = "nix flake";
        nr = "nix run";
        ns = "nix-shell";
        nq = "nix search";
        nd = ''
          nix develop ${nixConfigDirectory}#$argv[1] -c $SHELL
        '';
        ec = "cd ${nixConfigDirectory} && ${pkgs.neovim}/bin/nvim flake.nix";

        # Others
        nvim = "${neovim}/bin/nvim";
        e = "nvim";
        vi = "nvim";
        grep = "${ripgrep}/bin/rg";
        cat = "${bat}/bin/bat";
        du = "${du-dust}/bin/dust";
        ef = "exec ${fish}/bin/fish";
        y = "${yt-dlp}/bin/yt-dlp";
        y4 = "y --format 'bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]' $argv";
        l = "clear";
        clone = "${ghq}/bin/ghq get";
        cp = "cp -r";
        rm = "rm -ir";
        md = "mkdir -p";
        rpkgjson = ''
          ${nodejs}/bin/node -e "console.log(Object.entries(require('./package.json').$argv[1]).map(([k,v]) => k.concat(\"@\").concat(v)).join(\"\n\") )"
        '';

        # tmux
        tmux = "${tmux}/bin/tmux";
        pt = "tmux kill-session";
        tm = "tmux";
        tml = "tmux ls";
        t = "tmux attach";

        # ls / exa
        exa = "${exa}/bin/exa";
        ll = "exa --long --icons --all --group-directories-first --no-permissions --no-user --no-time --no-filesize";
        ls = "exa --long --icons --all --group-directories-first";
        lst = "exa --long --tree --group-directories-first --no-permissions --no-user --no-time --no-filesize";
        lstt = "exa --long --tree --group-directories-first --no-permissions --no-user --no-time --no-filesize --level=2";
        lsttt = "exa --long --tree --group-directories-first --no-permissions --no-user --no-time --no-filesize --level=3";
        lsd = "exa --long --icons --all --only-dirs";
        lsg = "exa --icons --grid --all --group-directories-first";

        # zip
        mtar = "tar -cvf"; # mtar <archive_compress>
        utar = "tar -xvf"; # utar <archive_decompress> <file_list>
        zip = "zip -r"; # zip <archive_compress> <file_list>
        uz = "unzip"; # uz <archive_decompress> -d <dir>

        # Git
        git = "${git}/bin/git";
        pullhead = "git pull origin (git rev-parse --abbrev-ref HEAD)";
        plh = "pullhead";
        pushhead = "git push origin (git rev-parse --abbrev-ref HEAD)";
        psh = "pushhead";
        gitignore = "curl -sL https://www.gitignore.io/api/$argv";
        gi = "gitignore";
        g = "git";
        gtemp = ''git commit -m "temp" --no-verify'';
        gf = "git flow";
        gl = "git log --graph --oneline --all";
        gll = "git log --oneline --decorate --all --graph --stat";
        gld = ''git log --oneline --all --pretty=format:"%h%x09%an%x09%ad%x09%s"'';
        gls = "gl --show-signature";
        gfa = "git fetch --all";
        grc = "git rebase --continue";
      }

      (lib.mkIf pkgs.stdenv.isDarwin {
        # `nix-darwin`
        drl = "darwin-rebuild --list-generations";
        drb = "darwin-rebuild build --flake ${nixConfigDirectory}#${config.home.user-info.username}";
        drs = "darwin-rebuild switch --flake ${nixConfigDirectory}#${config.home.user-info.username}";
        psc = "nix build ${nixConfigDirectory}#darwinConfigurations.${config.home.user-info.username}.system --json | jq -r '.[].outputs | to_entries[].value' | cachix push arifvn";
      })

      (lib.mkIf pkgs.stdenv.isLinux {
        # `home-manager`
        hml = "home-manager generations";
        hmb = "home-manager build --flake ${nixConfigDirectory}#${config.home.user-info.username}";
        hms = "home-manager switch --flake ${nixConfigDirectory}#${config.home.user-info.username}";
      })
    ];
in {home.shellAliases = shellAliases;}
