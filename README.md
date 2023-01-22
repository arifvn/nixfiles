# My Home Manager Configuration 

## Prerequisite
* Nix has been installed on your computer 
* Create symlinks:
```console
mkdir -p ~/.config/nixpkgs; mkdir -p ~/.config/nix
ln -s $(pwd)/home.nix ~/.config/nixpkgs/home.nix
ln -s $(pwd)/nix.conf ~/.config/nix/nix.conf
```

## Commands

### Build 

```console
# nix build --no-link .#homeConfigurations.<USERNAME>.activationPackage
nix build --no-link .#homeConfigurations.arifvn.activationPackage
```

### Switch

```console
# home-manager switch --flake .#<USERNAME>
home-manager switch --flake .#arifvn
```
