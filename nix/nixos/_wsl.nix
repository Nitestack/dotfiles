# ╭──────────────────────────────────────────────────────────╮
# │ NIXOS WSL CONFIGURATION                                  │
# ╰──────────────────────────────────────────────────────────╯
{ meta, pkgs, ... }:
{
  wsl = {
    enable = true;
    defaultUser = meta.username;
    docker-desktop.enable = true;
    startMenuLaunchers = true;
  };

  # ── Home Manager ──────────────────────────────────────────────────────
  home-manager.users.${meta.username} = import ../home-manager/_base.nix;

  # ── Packages ──────────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # Apps
    evince
  ];
}
