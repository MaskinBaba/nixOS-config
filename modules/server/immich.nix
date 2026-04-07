{
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/var/lib/immich";
  };
  services.immich-public-proxy.immichUrl = "https://immich.maskinscache.xyz";
}
