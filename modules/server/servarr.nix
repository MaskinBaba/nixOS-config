{ lib, config, ... }:
{
  services = {
    sonarr = {
      enable = true;
      openFirewall = true;
      user = "maskin";
    };

    radarr = {
      enable = true;
      openFirewall = true;
      user = "maskin";
    };

    prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
