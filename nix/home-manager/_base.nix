# ╭──────────────────────────────────────────────────────────╮
# │ BASE HOME MANAGER CONFIGURATION                          │
# ╰──────────────────────────────────────────────────────────╯
{
  meta,
  ...
}:
{
  # ── Imports ───────────────────────────────────────────────────────────
  imports = [
    ./bat.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./tmux.nix

    ./languages
    ./scripts
  ];

  # ── Configuration ─────────────────────────────────────────────────────
  home = {
    username = meta.username;
    homeDirectory = "/home/${meta.username}";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = "24.05";
  };

  xdg.enable = true;

  news.display = "show";

  # ── Programs ──────────────────────────────────────────────────────────
  programs = {
    btop.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    home-manager.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    # Module is not supporting custom path, so using it manually
    # oh-my-posh = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };
    ripgrep.enable = true;
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd"
        "cd"
      ];
    };
  };
}
