{ lib, config, ... }:
{
  services.vaultwarden = {
      enable = true;
      backupDir = "/var/services/vaultwarden/backup";
      # in order to avoid having  ADMIN_TOKEN in the nix store it can be also set with the help of an environment file
      # be aware that this file must be created by hand (or via secrets management like sops)
      environmentFile = config.sops.secrets."server/vaultwarden_env".path;
      config = {
          # Refer to https://github.com/dani-garcia/vaultwarden/blob/main/.env.template
          DOMAIN = "https://vault.maskinscache.xyz";
          SIGNUPS_ALLOWED = true;
  
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;
          ROCKET_LOG = "critical";
      };
  };
}
