{ pkgs, ... }: {
  home.packages = with pkgs;
    [
      (nerdfonts.override {
        fonts = [ "FiraCode" "CascadiaCode" "JetBrainsMono" "SourceCodePro" ];
      })
    ];
}
