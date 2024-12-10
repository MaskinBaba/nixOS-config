{
  description = "Flake for NixOS build.";

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs: 
  let
    lib = nixpkgs.lib;
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs{
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    
    # System Settings
    system = "x86_64-linux";
    ROG = "G513IE";
    bigblue = "bigblue";
    server = "hades";
    timezone = "Asia/Kolkata";
    profile = "personal";
    locale = "en_US.UTF-8";
    
    #User Settings
    userSettings = {
      username = "maskin";
      name = "Hemanshu";
      editor = "nvim";
      term = "foot";
      browser = "firefox";
    };
  in
  {
    nixosConfigurations."G513IE" = lib.nixosSystem {
      inherit system;
      specialArgs = { 
        inherit inputs;
        inherit pkgs;
        inherit pkgs-unstable;
      };

      modules = [ 
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        # inputs.nixpkgs-unstable.nixosModules.default
      ];
    };

  };
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    
    hyprland = {
      # url = "github:hyprwm/Hyprland?submodules=1";
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
