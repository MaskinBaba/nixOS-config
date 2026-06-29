{ config, lib, pkgs, ... }:
{

  services.onlyoffice = {
    enable = true;
    hostname = "marineford";
    securityNonceFile = "${pkgs.writeText "nixos-test-onlyoffice-nonce.conf" ''
      set $secure_link_secret "nixostest";
    ''}";
    jwtSecretFile = "kduDMH1mYs7QxXbrZhO4HN+pWIrKlQI8XfAtYo1Dmkk=";
    port = 8000;
    # enableExampleServer = true;
  };

  
}
