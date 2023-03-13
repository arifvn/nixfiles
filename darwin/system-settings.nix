{
  # these options can be found at
  # https://daiderd.com/nix-darwin/manual/index.html

  system.defaults.NSGlobalDomain = {
    "com.apple.trackpad.scaling" = 3.0; # Configures the trackpad tracking speed (0 to 3). The default is "1".
    "com.apple.swipescrolldirection" = false; # Whether to enable "Natural" scrolling direction. The default is true.

    AppleMetricUnits = 1;
    AppleMeasurementUnits = "Centimeters";
    AppleTemperatureUnit = "Celsius";

    # Set a shorter Delay until key repeat
    # https://apple.stackexchange.com/questions/261163/default-value-for-nsglobaldomain-initialkeyrepeat
    # https://apple.stackexchange.com/questions/411531/increase-keyrepeat-speed-in-macos-big-sur
    InitialKeyRepeat = 15;

    # Set a blazingly fast keyboard repeat rate
    KeyRepeat = 1;

    # Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
    AppleKeyboardUIMode = 3;

    # this might be a must if you want to increase KeyRepeat
    ApplePressAndHoldEnabled = false;
  };

  # Firewall
  system.defaults.alf = {
    globalstate = 1;
    allowsignedenabled = 1;
    allowdownloadsignedenabled = 1;
    stealthenabled = 1;
  };

  # Dock and Mission Control
  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.0;

    # Whether to automatically rearrange spaces based on most recent use. The default is true.
    mru-spaces = false;

    # Whether to group windows by application in Mission Control's Exposé. The default is true.
    expose-group-by-app = false;

    # Size of the icons in the dock. The default is 64.
    tilesize = 110;

    # Hot Corners
    wvous-bl-corner = 1; # Disabled
    wvous-br-corner = 4; # Desktop
    wvous-tl-corner = 11; # Disabled
    wvous-tr-corner = 2; # Mission Control
  };

  # Login and lock screen
  system.defaults.loginwindow = {
    GuestEnabled = false;
    DisableConsoleAccess = true;
  };

  # Trackpad
  system.defaults.trackpad = {
    # Whether to enable trackpad tap to click. The default is false.
    Clicking = true;

    # Whether to enable trackpad right click. The default is false.
    TrackpadRightClick = true;

    # Whether to enable tap-to-drag. The default is false.
    Dragging = true;

    # For normal click: 0 for light clicking, 1 for medium, 2 for firm. The default is 1.
    FirstClickThreshold = 0;
  };

  # Finder
  system.defaults.finder = {
    # Whether to show warnings when change the file extension of files. The default is true.
    FXEnableExtensionChangeWarning = true;

    # Whether to show all file extensions in Finder. The default is false.
    AppleShowAllExtensions = true;

    # Whether to allow quitting of the Finder. The default is false.
    QuitMenuItem = true;

    # Change the default search scope. Use "SCcf" to default to current folder. The default is unset ("This Mac").
    FXDefaultSearchScope = "SCcf";

    # Change the default finder view. "icnv" = Icon view, "Nlsv" = List view, "clmv" = Column View, "Flwv" = Gallery View The default is icnv.
    FXPreferredViewStyle = "Nlsv";
  };
}
