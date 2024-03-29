
{ config, pkgs, ... }:

let
  # unstable = import (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable) 
  #   { config = pkgs; };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "maxime";
  home.homeDirectory = "/home/maxime";

  nixpkgs.config = {
    allowUnfree = true;

    permittedInsecurePackages = [
      "electron-24.8.6"
    ];  
  };
  home.packages = with pkgs; [ 
    # Notes
    p3x-onenote
    obsidian
    # Entertainment
    discord
    spotify
    # Low-Level
    gcc
    # Web
    nodejs
    # Haskell
    ghc
    cabal-install
    stack
    haskell-language-server
    # Utils
    pass
    pandoc
    rnix-lsp
    imagemagick
    xclip
    tmux
    screen
  ];

  nixpkgs.overlays =
    let
      betterDiscord = self: super: {
        discord = super.discord.override { withOpenASAR = true; withVencord = true; };
      };
    in
      # [ betterDiscord ];
      [];

  imports = [ ./helix.nix ];

  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    initExtra = ''
      alias nedo=sudo
      source $HOME/.p10k.zsh
      source $HOME/.zshhook
      export PATH=$HOME/.ghcup/bin/:$HOME/.velle/:$PATH
      export PATH=$HOME/.config/nixpkgs/scripts/:$PATH
      export EDITOR=hx
      '';
  };
  
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}


