{ pkgs, ... }:
{
  # User Info
  hostname = "nixstation";
  username = "nhan";
  description = "Nhan Pham";
  # Theme
  theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  cursorTheme = {
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
  };
  iconTheme = {
    name = "WhiteSur";
    package = pkgs.whitesur-icon-theme.override {
      alternativeIcons = true;
      boldPanelIcons = true;
    };
  };
  # Fonts
  font = {
    sans = {
      name = "Rubik";
      package = pkgs.rubik;
    };
    mono = {
      name = "MonaspiceNe Nerd Font";
      package = pkgs.nerdfonts.override {
        fonts = [
          "Monaspace"
          "NerdFontsSymbolsOnly"
        ];
      };
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };
  };
}