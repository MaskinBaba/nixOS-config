{ config, nixpkgs, lib, pkgs, ... }:
{
  sops = {
    defaultSopsFile = ./../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age = {
      keyFile = "/home/maskin/.config/sops/age/keys.txt";
    };

    secrets."server/nextcloud_admin" = { };
    secrets."server/marineford_cf_tunnel_keys" = { };
    secrets."server/cf_read_tunnel_key" = { };
    secrets."server/vaultwarden_env" = { };
  };

}
