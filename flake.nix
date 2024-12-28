{
  description = "Flake for NixOS build.";

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: 
  let
    lib = nixpkgs.lib;
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs{
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    pkgs-unstable = import nixpkgs-unstable{
      inherit system;
      config = {
        allowUnfree = true;
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
      };

      modules = [ 
        ./configuration.nix
        inputs.home-manager.nixosModules.default
        # inputs.nixpkgs-unstable.nixosModules.default
      ];
    };

    homeConfigurations = {
      maskin = home-manager.lib.homeManagerConfiguration{
        pkgs = pkgs-unstable;
        # inherit system;
        modules = [
          ./home.nix
        ];
      };
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

    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
}
