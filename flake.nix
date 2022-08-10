{
  description = "Home Manager configuration of Maxime";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in
    {
      homeConfigurations.maxime = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        inherit system;
        configuration = import ./home.nix;
        homeDirectory = "/home/maxime";
        username = "maxime";

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        extraModules = [
          # ./home.nix
        ];
        extraSpecialArgs = { inherit (inputs) helix; };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        stateVersion = "21.05";
      };
    };
}
