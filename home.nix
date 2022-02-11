
{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "maxime";
  home.homeDirectory = "/home/maxime";

  nixpkgs.config = {
    allowUnfree = true;
  };
  home.packages = with pkgs; [ 
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
    imagemagick
    xclip
  ];


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
      export PATH=$HOME/.ghcup/bin/:$HOME/.velle/:$PATH
      export PATH=$HOME/.config/nixpkgs/scripts/:$PATH
    '';
  };

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


