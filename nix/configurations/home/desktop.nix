# ╭──────────────────────────────────────────────────────────╮
# │ NixOS Desktop Home Manager Configuration                 │
# ╰──────────────────────────────────────────────────────────╯
{
  flake,
  pkgs,
  config,
  ...
}:
let
  inherit (flake.inputs) self;
in
{
  # ── Imports ───────────────────────────────────────────────────────────
  imports = [
    self.homeModules.base

    self.homeModules.ghostty
    self.homeModules.hyprland
    self.homeModules.rofi
    self.homeModules.spicetify
    self.homeModules.swaync
    self.homeModules.theme
    self.homeModules.waybar
    self.homeModules.wezterm
    self.homeModules.wlogout
    self.homeModules.zen-browser
  ];

  # Configuration
  shells.zsh.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };

  xdg.desktopEntries =
    let
      googleChrome = "${pkgs.google-chrome}/bin/google-chrome-stable";
    in
    {
      snapdrop = {
        name = "Snapdrop";
        comment = "The easiest way to transfer files across devices";
        categories = [
          "Network"
          "FileTransfer"
        ];
        exec = "${googleChrome} --app=https://snapdrop.net --name=Snapdrop";
        icon = "${pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/snapdrop/snapdrop/master/client/images/logo_transparent_512x512.png";
          sha256 = "sha256-QMgXdeaNxg+e71dKAojR1h1zcpwBCNX10JQfD0fqhes=";
        }}";
      };
      whatsapp = {
        name = "WhatsApp";
        comment = "Quickly send and receive WhatsApp messages right from your computer.";
        categories = [
          "Network"
        ];
        exec = "${googleChrome} --app=https://web.whatsapp.com --name=WhatsApp";
        icon = "${pkgs.fetchurl {
          url = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/WhatsApp.svg/240px-WhatsApp.svg.png";
          sha256 = "15spvy9w3aj3nx161z60wkhqswrp13j5kp4v2sijbmd36myg38xj";
        }}";
      };
    };

  # Nautilus
  gtk.gtk3.bookmarks =
    let
      home = config.home.homeDirectory;
    in
    [
      "file://${config.xdg.userDirs.documents}"
      "file://${home}/Studium"
      "file://${config.xdg.userDirs.pictures}"
      "file://${config.xdg.userDirs.videos}"
      "file://${config.xdg.userDirs.download}"
      "file://${config.xdg.userDirs.music}"
    ];

  # ── Programs ──────────────────────────────────────────────────────────
  programs = {
    cava.enable = true;
    vscode.enable = true;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  # ── Services ──────────────────────────────────────────────────────────
  services = {
    cliphist.enable = true;
    easyeffects.enable = true;
    mpris-proxy.enable = true;
  };
}
