# ╭──────────────────────────────────────────────────────────╮
# │ Neovim                                                   │
# ╰──────────────────────────────────────────────────────────╯
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  xdg.configFile."nvim/after".source = ./after;
  xdg.configFile."nvim/lua".source = ./lua;
  xdg.configFile."nvim/init.lua".source = ./init.lua;

  home.packages = with pkgs; [
    # NOTE: LSP's (# pnpm add -g @prisma/language-server cssmodules-language-server markdown-toc)
    angular-language-server
    ansible-language-server
    bash-language-server
    dockerfile-language-server-nodejs
    docker-compose-language-service
    emmet-language-server
    gopls
    lua-language-server
    marksman
    nixd
    nushell
    pyright
    rust-analyzer
    tailwindcss-language-server
    taplo
    tinymist
    vscode-langservers-extracted
    vtsls
    yaml-language-server

    # Debuggers
    python312Packages.debugpy
    vscode-js-debug

    # Linters
    ansible-lint
    eslint_d
    hadolint
    markdownlint-cli2
    ruff
    selene
    shellcheck

    # Formatters
    bibtex-tidy
    black
    gofumpt
    gotools
    prettierd
    nixfmt
    nufmt
    shfmt
    stylua

    gcc
    ghostscript
    imagemagick
    tree-sitter
    typst
  ];
}
