{
  description = "Flake for NixOS build.";

  outputs = { self, nixpkgs, nixpkgs-unstable, winapps, home-manager, ... }@inputs: 
  let
    lib = nixpkgs.lib;
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs{
      inherit system;
      config = {
        allowUnfree = true;
	permittedInsecurePackages = [
          "electron-33.4.11"
        ];
      };
    };
    pkgs-unstable = import nixpkgs-unstable{
      inherit system;
      config = {
        allowUnfree = true;
	permittedInsecurePackages = [
          "electron-33.4.11"
        ];
      };
      overlays = [
        inputs.nix-matlab.overlay
      ];
    };
    # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    
    # System Settings
    system = "x86_64-linux";
    ROG = "G513IE";
    bigblue = "bigblue";
    server = "hades";
    timezone = "Asia/Kolkata";
    profile = "personal";
    locale = "en_IN";
    localeUS = "en_US.UTF-8";
    
    #User Settings
    userSettings = {
      username = "maskin";
      name = "Hemanshu";
      email = "hemanshu@maskinscache.xyz";
      editor = "nvim";
      term = "foot";
      browser = "firefox";
      dots = "~/.dotfiles";
      wm = "hyprland";
    };
  in
  {
    nixosConfigurations."G513IE" = lib.nixosSystem {
      inherit system;
      specialArgs = { 
        inherit inputs;
        inherit pkgs;
        inherit pkgs-unstable;
        inherit timezone;
        inherit locale;
	inherit system;
      };

      modules = [ 
        ./hosts/G513IE/configuration.nix
        inputs.home-manager.nixosModules.default
        # inputs.nixpkgs-unstable.nixosModules.default

	(
          {
            pkgs-unstable,
            system ? pkgs-unstable.system,
            ...
          }:
          {
            environment.systemPackages = [
              winapps.packages."${system}".winapps
              winapps.packages."${system}".winapps-launcher # optional
            ];
          }
        )
      ];
    };

    homeConfigurations = {
      maskin = home-manager.lib.homeManagerConfiguration{
        pkgs = pkgs-unstable;
        # inherit system;
        extraSpecialArgs = { inherit inputs; };

        modules = [
          ./hosts/G513IE/home.nix
        ];
      };
    };
  };
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
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

    Hyprspace = {
      url = "github:KZDKM/Hyprspace";

      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    helix = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
}
