# ╭──────────────────────────────────────────────────────────╮
# │ Hyprlock                                                 │
# ╰──────────────────────────────────────────────────────────╯
{
  meta,
  pkgs,
  ...
}:
let
  inherit (meta) font;

  wallpaper = ../../../../images/wallpapers/black-hole.png;
  user_avatar = ../../../../images/user-avatar.png;

  scripts = {
    layout-status = pkgs.writeShellScriptBin "layout-status" ''
      #!/usr/bin/env bash

      layout="$(bat /etc/vconsole.conf | grep XKBLAYOUT | awk -F'=' '{print toupper($2)}')"
      printf "%s   " "$layout"
    '';
    network-status = pkgs.writeShellScriptBin "network-status" ''
      #!/usr/bin/env bash

      status="$(nmcli general status | grep -oh "\w*connect\w*")"

      if [[ "$status" == "disconnected" ]]; then
        printf "󰤮 "
      elif [[ "$status" == "connecting" ]]; then
        printf "󱍸 "
      elif [[ "$status" == "connected" ]]; then
        printf "󰈀 "
      fi
    '';
    song-status = pkgs.writeShellScriptBin "song-status" ''
      #!/usr/bin/env bash

      player_name=$(playerctl metadata --format '{{playerName}}')
      player_status=$(playerctl status)

      if [[ "$player_status" == "Playing" ]]; then
        case "$player_name" in
        "spotify")
          player_icon=""
          ;;
        "firefox")
          player_icon=""
          ;;
        *)
          player_icon=""
          ;;
        esac

        playerctl metadata --format "$player_icon {{title}} - {{artist}}"
      else
        echo ""
      fi
    '';
  };
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      # ── Background ────────────────────────────────────────────────────────
      background = {
        monitor = "";
        path = "${wallpaper}"; # only png supported for now
        color = "rgba(25, 20, 20, 1.0)";

        # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
        blur_passes = 0; # 0 disables blurring
        blur_size = 2;
        noise = 0;
        contrast = 0;
        brightness = 0;
        vibrancy = 0;
        vibrancy_darkness = "0.0";
      };

      # ── Input Field ───────────────────────────────────────────────────────
      input-field = {
        monitor = "";
        size = "200, 30";
        outline_thickness = 0;
        dots_size = 0.25; # Scale of input-field height, 0.2 - 0.8
        dots_spacing = 0.55; # Scale of dots' absolute size, 0.0 - 1.0
        dots_center = true;
        dots_rounding = -1;
        outer_color = "rgba(242, 243, 244, 0.25)";
        inner_color = "rgba(242, 243, 244, 0.25)";
        font_color = "rgba(242, 243, 244, 0.75)";
        font_family = font.sans.name;
        fade_on_empty = false;
        placeholder_text = "Enter Password"; # Text rendered in the input box when it's empty.
        hide_input = false;
        check_color = "rgba(204, 136, 34, 0)";
        fail_color = "rgba(204, 34, 34, 0)"; # if authentication failed, changes outer_color and fail message color
        fail_text = "$FAIL <b>($ATTEMPTS)</b>"; # can be set to empty
        capslock_color = -1;
        numlock_color = -1;
        bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
        invert_numlock = false; # change color if numlock is off
        swap_font_color = false; # see below
        position = "0, -470";
        halign = "center";
        valign = "center";
      };

      # ── Labels ────────────────────────────────────────────────────────────
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(${scripts.song-status}/bin/song-status)\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 14;
          font_family = font.nerd.propoName;
          position = "20, 508";
          halign = "left";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(${scripts.network-status}/bin/network-status)\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 15;
          font_family = font.nerd.propoName;
          position = "920, 507";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(${scripts.layout-status}/bin/layout-status)\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 14;
          font_family = font.nerd.propoName;
          position = "796, 508";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(LC_TIME=\"en_US.UTF-8\" date +\"%A, %B %-d\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 20;
          font_family = "${font.sans.titleName} Bold";
          position = "0, 435";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"\$(date +\"%-H:%M\")\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 93;
          font_family = "${font.sans.titleName} Bold";
          position = "0, 350";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:0] echo \"${meta.description}\"";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 12;
          font_family = "${font.sans.name} Bold";
          position = "0, -435";
          halign = "center";
          valign = "center";
        }
      ];

      # ── Image ─────────────────────────────────────────────────────────────
      image = {
        monitor = "";
        path = "${user_avatar}";
        border_color = "0xffdddddd";
        border_size = 0;
        size = 73;
        rounding = -1;
        rotate = 0;
        reload_time = -1;
        reload_cmd = "";
        position = "0, -375";
        halign = "center";
        valign = "center";
      };
    };
  };
}
