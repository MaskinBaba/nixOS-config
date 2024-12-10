{ config, nixpkgs, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/hardware-configuration.nix
      ./config/sysNnix.nix
      ./config/programs.nix
      ./modules/packages.nix
      ./modules/user.nix
      inputs.home-manager.nixosModules.default
    ];

  # Enable zsh as default shell
  users.defaultUserShell = pkgs.zsh;
  user.enable = true;
  user.userName = "maskin";
  
  # virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
 
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "maskin" = import ./home.nix;
    };
  };
 
  fonts.packages = with pkgs; [
    # nerd-fonts.iosevka
    nerdfonts
    font-awesome
    google-fonts
  ];

  nixpkgs.config.allowUnfree = true;
  # nixpkgs-unstable.config.allowUnfree = true;
}
