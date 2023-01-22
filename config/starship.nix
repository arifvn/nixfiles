{ ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file.".config/starship.toml".text = ''
    # source : https://starship.rs/presets/nerd-font.html

    [character]    
    success_symbol = "[➜](bold green)"
    error_symbol = "[✗](bold red)"
    vicmd_symbol = '[V](bold green)'

    [aws]
    symbol = "  "

    [buf]
    symbol = " "

    [c]
    symbol = " "

    [conda]
    symbol = " "

    [dart]
    symbol = " "

    [directory]
    read_only = " "
    truncation_length = 8

    [docker_context]
    symbol = " "

    [elixir]
    symbol = " "

    [elm]
    symbol = " "

    [git_branch]
    symbol = " "

    [golang]
    symbol = " "

    [guix_shell]
    symbol = " "

    [haskell]
    symbol = " "

    [haxe]
    symbol = "⌘ "

    [hg_branch]
    symbol = " "

    [java]
    symbol = " "

    [julia]
    symbol = " "

    [lua]
    symbol = " "

    [memory_usage]
    symbol = " "

    [meson]
    symbol = "喝 "

    [nim]
    symbol = " "

    [nix_shell]
    symbol = " "

    [nodejs]
    symbol = " "

    [os.symbols]
    Alpine = " "
    Amazon = " "
    Android = " "
    Arch = " "
    CentOS = " "
    Debian = " "
    DragonFly = " "
    Emscripten = " "
    EndeavourOS = " "
    Fedora = " "
    FreeBSD = " "
    Garuda = "﯑ "
    Gentoo = " "
    HardenedBSD = "ﲊ "
    Illumos = " "
    Linux = " "
    Macos = " "
    Manjaro = " "
    Mariner = " "
    MidnightBSD = " "
    Mint = " "
    NetBSD = " "
    NixOS = " "
    OpenBSD = " "
    openSUSE = " "
    OracleLinux = " "
    Pop = " "
    Raspbian = " "
    Redhat = " "
    RedHatEnterprise = " "
    Redox = " "
    Solus = "ﴱ "
    SUSE = " "
    Ubuntu = " "
    Unknown = " "
    Windows = " "

    [package]
    symbol = " "

    [python]
    symbol = " "

    [rlang]
    symbol = "ﳒ "

    [ruby]
    symbol = " "

    [rust]
    symbol = " "

    [scala]
    symbol = " "

    [spack]
    symbol = "🅢 "
  '';
}