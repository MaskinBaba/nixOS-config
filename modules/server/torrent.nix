{ lib, config, ... }:
{
  services.qbittorrent = {
    enable = true;
    user = "maskin";
    webuiPort = 8080;
    openFirewall = true;
    serverConfig = {
      LegalNotice.Accepted = true;
      Preferences = {
        WebUI = {
          Username = "torrent";
          Password_PBKDF2 = "@ByteArray(XkHvnLfOFlGmsVkThvJASA==:c30qNxijO/wD8iH5b4SG5uDIvWJOcz9xNPhqMOOloDI3mlSchv5kE2T9zKVzj5abiEJGkS+YEGds7Z5XoAO3Dg==)";
        };
        General.Locale = "en";
      };
    };

  };
}
