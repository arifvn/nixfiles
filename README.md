# My Nix Configuration on MacOS & Ubuntu 🖥️

## Prerequisite

- Install nix using [unofficial nix installer](https://zero-to-nix.com/).

```console
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## Build

#### Darwin

1. Create `/run` directory as `nix-darwin` [needs](https://github.com/LnL7/nix-darwin#Manual-install) it.

```console
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
```

2. Install [homebrew](https://brew.sh/).

```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Build and apply your configuration.

```console
nix build .#darwinConfigurations.arifvn.system
./result/sw/bin/darwin-rebuild switch --flake .#arifvn
```

4. Switch configuration.

- `drs` (to build and switch your configuration)
- `psc` (to build and cache your configuration)

#### Ubuntu

```console
nix build .#homeConfigurations.arifvn.activationPackage
./result/activate
```

## Possible Issues

#### Darwin

- `warning: failed to execute apfs.util`. If you encountered [it](https://github.com/LnL7/nix-darwin/issues/401), you might have needed to restart your machine.
- `warning: can't link /etc/shells` or `warning can't link /etc/nix/nix.conf`. You might get them saying that files under `/etc` can't be linked as they already exist. You'll need to delete those files and run `darwin-rebuild switch` again. It'd be good if you had those files backed up first, just in case.

```console
sudo cp /etc/shells /etc/shells.bak && sudo rm /etc/shells
sudo cp /etc/bashrc /etc/bashrc.bak && sudo rm /etc/bashrc
sudo cp /etc/nix/nix.conf /etc/nix/nix.conf.bak

nix build .#darwinConfigurations.arifvn.system --extra-experimental-features nix-command --extra-experimental-features flakes
./result/sw/bin/darwin-rebuild switch --flake .#arifvn
```

- `command not found: darwin-rebuild`. Are nix and `darwin-rebuild` available in your shell if you open a new terminal and run `exec /run/current-system/sw/bin/fish`? If so, you might need to run `chsh` to set the default shell that terminal emulators on your system will use. Try running `chsh -s /run/current-system/sw/bin/fish` to set Fish as your default shell.

- Some system settings like Dock settings or Finder settings might only take effects after you reboot your machine.

- Some apps might need to be configured mannually afterward as they don't come up with configuration files including `android-studio`, `istat-menus` and `raycast`.

#### Ubuntu

✅ None. It hasn't been found yet.

## Acknowledgements

Usefull nix config repos (very much inspire this repo) :

- ✨ [mablob/nixpkgs](https://github.com/malob/nixpkgs)
- ✨ [r17x/nixpkgs](https://github.com/r17x/nixpkgs)

Nix builtin functions:

- [inherit](https://nixos.org/manual/nix/stable/language/constructs.html)
- [attrValues](https://ryantm.github.io/nixpkgs/functions/library/attrsets/#function-library-lib.attrsets.attrValues)
- [singleton](https://ryantm.github.io/nixpkgs/functions/library/lists/)
- [makeOverridable](https://ryantm.github.io/nixpkgs/using/overrides/)
- [lib.options](https://github.com/NixOS/nixpkgs/blob/master/lib/options.nix)
- [attrsets.optionalAttrs](https://ryantm.github.io/nixpkgs/functions/library/attrsets/#function-library-lib.attrsets.optionalAttrs)
- [lib.mkMerge](https://github.com/nix-community/home-manager/issues/414)
- [config argument](https://nixos.wiki/wiki/NixOS:config_argument)

Tutorials:

- [Declarative macOS Configuration Using nix-darwin And home-manager](https://xyno.space/post/nix-darwin-introduction)
- [An unofficial, opinionated, gentle introduction to Nix](https://zero-to-nix.com/)
- [Setup home-manager for standalone use on Macos](https://gist.github.com/bsag/552a68a198df04ddbc9ddb7b16b170bf)
- [Setup nix-darwin/home-manager from scratch](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)
- [Darwin Manual](https://daiderd.com/nix-darwin/manual/index.html#sec-options)
- [Some Issues and Discussions about this original repo](https://github.com/malob/nixpkgs/discussions/6)
- [How to uninstall nix on MacOS](https://iohk.zendesk.com/hc/en-us/articles/4415830650265-Uninstall-nix-on-MacOS)
