{ config, lib, ...}: {
  networking = {
    hostName = "G513IE";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    dhcpcd = {
      enable = true;
      wait = "background";
    };
  };
}