# ╭──────────────────────────────────────────────────────────╮
# │ tmux                                                     │
# ╰──────────────────────────────────────────────────────────╯
{ pkgs, ... }:
{
  programs.tmux = rec {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 1;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "$TERM";
    resizeAmount = 5;

    extraConfig = ''
      # Options
      set -as terminal-features "$TERM:RGB" # 24-bit color

      set -g renumber-windows on # Renumber windows when a window is closed
      set -g detach-on-destroy off # Don't exit from tmux when closing a session
      set -g set-clipboard on # Use system clipboard

      # Appearance
      set -g status-position "top"

      # Copy Mode
      unbind [
      bind-key v copy-mode
      unbind ]
      bind-key p paste-buffer

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

      # Keybindings

      # Switch windows
      unbind C-p
      bind -n C-M-h previous-window
      unbind C-n
      bind -n C-M-l next-window
      # Rename window
      unbind ,
      bind r command-prompt "rename-window %%"
      # Reload Tmux config
      bind R source-file ~/.config/tmux/tmux.conf \; display "Tmux config reloaded!"
      # Split windows
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"
      # Resize windows
      unbind Right
      bind -r Right resize-pane -R ${toString resizeAmount}
      unbind Left
      bind -r Left resize-pane -L ${toString resizeAmount}
      unbind Up
      bind -r Up resize-pane -U ${toString resizeAmount}
      unbind Down
      bind -r Down resize-pane -D ${toString resizeAmount}
      unbind z
      bind -r Space resize-pane -Z
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = "set -g @continuum-restore 'on'";
      }
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          unbind o
          set -g @sessionx-bind "o"
          set -g @sessionx-window-height "85%"
          set -g @sessionx-window-width "75%"
          set -g @sessionx-zoxide-mode "on"
        '';
      }
      {
        plugin = tokyo-night-tmux;
        extraConfig = ''
          # ID styles
          set -g @tokyo-night-tmux_window_id_style digital
          set -g @tokyo-night-tmux_pane_id_style hide
          set -g @tokyo-night-tmux_zoom_id_style dsquare

          # Widgets
          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative

          set -g @tokyo-night-tmux_show_git 1

          # Disabled widgets
          set -g @tokyo-night-tmux_show_battery_widget 0
          set -g @tokyo-night-tmux_show_datetime 0
          set -g @tokyo-night-tmux_show_music 0
        '';
      }
      tmuxPlugins.resurrect
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
    ];
  };
}