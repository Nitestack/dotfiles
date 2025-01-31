{ pkgs, ... }:
{
  # User Info
  username = "nhan";
  description = "Nhan Pham";
  # Fonts
  font = {
    sans = {
      name = "Geist";
      package = pkgs.geist-font;
    };
    nerd = {
      name = "GeistMono NF";
      monoName = "GeistMono NFM";
      propoName = "GeistMono NFP";
      packages = with pkgs.nerd-fonts; [
        iosevka
        geist-mono
        symbols-only
      ];
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };
  };
  # Themes
  gtkTheme = {
    name = "Catppuccin-GTK-Dark";
    package = pkgs.magnetic-catppuccin-gtk.override {
      tweaks = [ "macos" ];
    };
  };
  cursorTheme = {
    name = "catppuccin-mocha-blue-cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 24;
  };
  iconTheme = {
    name = "WhiteSur";
    package = pkgs.whitesur-icon-theme.override {
      alternativeIcons = true;
      boldPanelIcons = true;
    };
  };
  kvantumTheme = {
    name = "catppuccin-mocha-blue";
    package = pkgs.catppuccin-kvantum.override {
      variant = "mocha";
    };
  };
}
