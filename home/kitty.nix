{
  pkgs,
  lib,
  ...
}:
lib.mkMerge [
  {
    xdg.configFile."kitty/kitty.conf".text = ''
      font_family      CaskaydiaCove Nerd Font
      bold_font        CaskaydiaCove Nerd Font Bold
      italic_font      CaskaydiaCove Nerd Font Italic
      bold_italic_font CaskaydiaCove Nerd Font Bold Italic

      adjust_line_height 115%

      window_padding_width 10 15
      confirm_os_window_close 0
      remember_window_size yes

      shell ${pkgs.fish}/bin/fish

      background_opacity 1

      enable_audio_bell no

      cursor_beam_thickness 1.5
      cursor_blink_interval -1
      cursor_stop_blinking_after 5.0

      # Colors
      foreground #abb2bf
      background #1f2329

      color0 #1e2127
      color1 #e06c75
      color2 #98c379
      color3 #d19a66
      color4 #61afef
      color5 #c678dd
      color6 #56b6c2
      color7 #828791
      color8 #5c6370
      color9 #e06c75
      color10 #98c379
      color11 #d19a66
      color12 #61afef
      color13 #c678dd
      color14 #56b6c2
      color15 #e6efff

      # Tab Bar
      active_tab_foreground   #282c34
      active_tab_background   #979eab
      inactive_tab_foreground #abb2bf
      inactive_tab_background #282c34
    '';
  }

  (lib.mkIf pkgs.stdenv.isLinux {
    programs.kitty = let
      nixGLWrap = pkg:
        pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
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
      enable = true;
      package = nixGLWrap pkgs.kitty;
    };

    xdg.configFile."kitty/kitty.conf".text = ''
      modify_font cell_height -4px
      font_size 11
      adjust_column_width 104%
      hide_window_decorations no
      wayland_titlebar_color #1f2329 
    '';
  })

  (lib.mkIf pkgs.stdenv.isDarwin {
    xdg.configFile."kitty/kitty.conf".text = ''
      font_size 13
      adjust_column_width 100%
      macos_titlebar_color #1f2329
      macos_thicken_font 0.2
      macos_window_resizable yes
      macos_hide_titlebar no
    '';
  })
]
