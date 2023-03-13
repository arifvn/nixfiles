{pkgs, ...}: {
  fonts.fonts = with pkgs; [
    recursive
    (nerdfonts.override {
      fonts = ["FiraCode" "CascadiaCode"];
    })
  ];

  # ENABLED when fontrestore issue in monterey is solved
  fonts.fontDir.enable = true;
}
