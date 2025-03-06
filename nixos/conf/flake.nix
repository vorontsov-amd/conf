{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    xmonad-contexts = {
      url = "github:Procrat/xmonad-contexts";
      flake = false;
    };

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, xmonad-contexts, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit system;
            inherit self;
            inherit xmonad-contexts;
          };
          modules = [ 
            ./configuration.nix
            # inputs.home-manager.nixosModules.default
          ];
        };
      };

    };
}

