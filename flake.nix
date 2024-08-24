{
  description = "Flake for NixOS build.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    #hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hyprland.url = "github:hyprwm/Hyprland";
    #hyprland.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations."G513IE" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ 
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

  };
}
