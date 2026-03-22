{ config, nixpkgs, nixpkgs-unstable, pkgs, pkgs-unstable, lib, inputs, timezone, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./../../config/sysNnix.nix
      ./../../config/programs.nix
      ./../../config/network.nix
      ./../../modules/packages.nix
      ./../../modules/user.nix
      ./../../config/timenlocal.nix
    ];

  users.groups.libvirtd.members = ["maskin"];

  main-user = {
    enable = true;
    userName = "maskin";
    description = "Maskin";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "maskin" "dialout" "input" "kvm" "libvirtd" "docker" "plugdev" ];
  };
  # virtualisation.docker.enable = true;

  virtualisation = {
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
    spiceUSBRedirection.enable = true;
  };
 
  fonts = {
    fontDir.enable = true;
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      # nerd-fonts.iosevka
      # nerdfonts
      font-awesome
      google-fonts
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts) ;
  };
}
