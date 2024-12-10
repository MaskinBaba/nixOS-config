{ config, pkgs, inputs, ...}: 
{
  programs = {
    light.enable = true;

    # Install firefox.
    firefox.enable = true;
  
    # Install zsh
    zsh.enable = true;
  
    hyprland = {
      enable = true;
      xwayland.enable = true;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    steam = {
      enable = true;
      package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [

      # Add any missing dynamic libraries for unpackaged programs

      # here, NOT in environment.systemPackages

       ];
    };
  };
}
