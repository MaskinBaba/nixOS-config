{ config, nixpkgs, pkgs, lib, inputs, timezone, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./modules/hardware-configuration.nix
      ./config/sysNnix.nix
      ./config/programs.nix
      ./config/network.nix
      ./modules/packages.nix
      ./modules/user.nix
      ./config/timenlocal.nix
      inputs.home-manager.nixosModules.default
    ];

  main-user = {
    enable = true;
    userName = "maskin";
    description = "Maskin";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "maskin" "dialout" ];
  };
  # virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
 
  fonts = {
    fontDir.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      # nerd-fonts.iosevka
      nerdfonts
      font-awesome
      google-fonts
    ];
  };
}
