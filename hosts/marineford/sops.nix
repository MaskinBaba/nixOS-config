{ config, nixpkgs, lib, pkgs, ... }:
{
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/home/maskin/.config/sops/age/keys.txt";
    };
  };

}