# ╭──────────────────────────────────────────────────────────╮
# │ defaults                                                 │
# ╰──────────────────────────────────────────────────────────╯
{
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      show-recents = false;
    };
    finder = {
      FXEnableExtensionChangeWarning = false; # hide warnings when change the file extension of files
      ShowExternalHardDrivesOnDesktop = false; # hide external disks on desktop
      ShowRemovableMediaOnDesktop = false; # hide removable media (CDs, DVDs and iPods) on desktop
      ShowPathbar = true;
      _FXSortFoldersFirst = true; # keep folders on top when sorting by name
    };
    screencapture = {
      disable-shadow = true; # disable drop shadow border around screencaptures
      location = "~/Pictures/Screenshots";
    };
    trackpad.Clicking = true; # enable tap to click
    LaunchServices.LSQuarantine = false; # turn off the "Application Downloaded from Internet" quarantine warning
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 2; # enable moving focus with Tab and Shift Tab (`2` on macOS Sonoma or later, `3` on older versions)
      ApplePressAndHoldEnabled = false; # disable the press-and-hold feature
      AppleScrollerPagingBehavior = true; # jump to the spot that’s clicked on the scroll bar
      AppleShowAllExtensions = true; # show all file extensions in Finder
      AppleShowAllFiles = true; # show hidden files
      NSDocumentSaveNewDocumentsToCloud = false; # don't save new documents to iCloud
      "com.apple.keyboard.fnState" = true; # use F1, F2, etc. keys as standard function keys
      "com.apple.swipescrolldirection" = false; # disable “Natural” scrolling direction
    };
  };
}
