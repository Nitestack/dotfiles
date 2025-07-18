# ╭──────────────────────────────────────────────────────────╮
# │ Theme                                                    │
# ╰──────────────────────────────────────────────────────────╯
{ meta, ... }:
let
  inherit (meta)
    font
    cursorTheme
    gtkTheme
    iconTheme
    kvantumTheme
    ;

in
{
  home = {
    packages = [
      kvantumTheme.package
    ];
    pointerCursor = cursorTheme // {
      gtk.enable = true;
    };
    sessionVariables = {
      GTK_THEME = gtkTheme.name;

      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
      HYPRCURSOR_THEME = cursorTheme.name;
      HYPRCURSOR_SIZE = "${toString cursorTheme.size}";
    };
  };

  gtk = {
    inherit cursorTheme iconTheme;
    enable = true;
    theme = gtkTheme;
    font = {
      inherit (font.sans) name package;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=${kvantumTheme.name}
  '';
  xdg.configFile."Kvantum/${kvantumTheme.name}".source =
    "${kvantumTheme.package}/share/Kvantum/${kvantumTheme.name}";

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ font.serif.name ];
      sansSerif = [ font.sans.name ];
      monospace = [
        font.nerd.name
        font.nerd.monoName
        font.nerd.propoName
      ];
      emoji = [ font.emoji.name ];
    };
  };

  dconf = {
    enable = true;
    settings =
      let
        # GTK settings
        gtk_settings = {
          show-hidden = true;
          sort-directories-first = true;
          startup-mode = "cwd";
        };
      in
      {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          clock-format = "24h";
          document-font-name = font.serif.name;
          font-antialiasing = "rgba";
          font-hinting = "full";
          monospace-font-name = font.nerd.monoName;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          titlebar-uses-system-font = false;
          titlebar-font = font.sans.titleName;
        };
        "org/gnome/nautilus/preferences" = {
          default-folder-viewer = "icon-view";
          show-delete-permanently = true;
        };
        "org/gnome/calculator" = {
          show-thousands = true;
        };
        "org/gtk/settings/file-chooser" = gtk_settings;
        "org/gtk/gtk4/settings/file-chooser" = gtk_settings;
      };
  };
}
