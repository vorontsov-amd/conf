{
  description = "Home Manager configuration of alex";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
        };

        amadey = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
    
          modules = [ ./home.nix ];
        };
      in
      {
        packages.homeConfigurations.amadey = amadey;
        packages.homeConfigurations.default = amadey;
      }
    );
}
