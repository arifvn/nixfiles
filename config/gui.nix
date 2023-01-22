{ pkgs, lib, ... }:
let
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
         echo "exec ${
           lib.getExe pkgs.nixgl.nixGLIntel
         } $bin \"\$@\"" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {
  home.packages = with pkgs; [
    # Development
    (nixGLWrap kitty)
    # (nixGLWrap alacritty)
    # vscode
    # postman
    # vivaldi

    # Misc
    # vlc
    # zoom-us
    # discord-ptb
  ];

  home.file = {
    ".config/kitty/kitty.conf".source = ./kitty.conf;
    # ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
  };
}
