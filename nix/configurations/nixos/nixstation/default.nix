# ╭──────────────────────────────────────────────────────────╮
# │ NixOS Desktop Configuration                              │
# ╰──────────────────────────────────────────────────────────╯
{
  flake,
  pkgs,
  config,
  ...
}:
let
  inherit (flake.inputs) self;
  inherit (config) meta;
in
{
  imports = [
    ./hardware-configuration.nix

    self.nixosModules.base
    self.nixosModules.linux-only
    self.nixosModules.gui-only

    self.nixosModules.audio
    self.nixosModules.backlight
    self.nixosModules.boot
    self.nixosModules.flatpak
    self.nixosModules.games
    self.nixosModules.gnome
    self.nixosModules.hyprland
  ];

  # ── Home Manager ──────────────────────────────────────────────────────
  home-manager.users.${meta.username} = {
    imports = [ (self + /configurations/home/desktop.nix) ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    # Apps
    (bottles.override {
      removeWarningPopup = true;
    })
    endeavour
    ente-auth
    protonmail-desktop
    protonvpn-gui
    stremio
    wasistlos

    # NixOS
    gnome-system-monitor
  ];

  # Virtualization
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };

  # Services
  services = {
    blueman.enable = true;
    playerctld.enable = true;
    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];
    };
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  # Network
  networking = {
    networkmanager.enable = true;
    hostName = "nixstation";
    # Spotify
    firewall = {
      allowedTCPPorts = [ 57621 ]; # sync local tracks from fs with mobile devices in the same network
      allowedUDPPorts = [ 5353 ]; # enables discovery of Spotify Connect devices
    };
  };
}
