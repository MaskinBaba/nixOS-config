{ config, pkgs, inputs, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # System tags
  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberry-pi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];

  # Experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.initrd.systemd.enable = false;

  # Enable Fwupd
  services.fwupd.enable = true;

  # Enable automatic optimisation
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  nix.settings = {
    substituters = [
      "https://attic.mintux.de/cameo007"
      "https://nixos-raspberrypi.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cameo007:rZXjerhPngqzNCb4U0M8Z874xlvqG7zqARhw/bxl0YY="
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };

  # Networking
  networking = {
    hostName = "marinefordv2";
    networkmanager.enable = true;

    # Enable firewall
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ]; # SSH
      allowedUDPPorts = [ ];
    };

    # Use iwd instead of wpa_supplicant. It has a user friendly CLI
    wireless.enable = false;
    wireless.iwd.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  networking.timeServers = [
    "ptbtime1.ptb.de"
    "ptbtime2.ptb.de"
    "ptbtime3.ptb.de"
    "ptbtime4.ptb.de"
  ];

  # Set NTS servers
  services.chrony = {
    enable = true;
    enableNTS = true;
    servers = [
      "ptbtime1.ptb.de"
      "ptbtime2.ptb.de"
      "ptbtime3.ptb.de"
      "ptbtime4.ptb.de"
    ];
  };

  # German language
  # i18n.extraLocales = [ "en_IN" ];
  # i18n.defaultLocale = "en_US.UTF-8";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable sound with ALSA.
  security.rtkit.enable = true;
  hardware.alsa.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    wget
  ];

  # Enable Git
  programs.git.enable = true;
  programs.git.config.safe.directory = "/etc/nixos";

  # Disable root user
  users.users.root.hashedPassword = "";

  # Don't require sudo/root to `reboot` or `poweroff`.
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function (action, subject) {
        if (
          subject.isInGroup("users") &&
          [
            "org.freedesktop.login1.reboot",
            "org.freedesktop.login1.reboot-multiple-sessions",
            "org.freedesktop.login1.power-off",
            "org.freedesktop.login1.power-off-multiple-sessions",
          ].indexOf(action.id) !== -1
        ) {
          return polkit.Result.YES;
        }
      });
    '';
  };

  # Limit journald log size
  services.journald.extraConfig = "SystemMaxUse=100M";

  # Enable OpenSSH server
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "yes";
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = true;
  };



  # Do not take down the network for too long when upgrading,
  # This also prevents failures of services that are restarted instead of stopped.
  # It will use `systemctl restart` rather than stopping it with `systemctl stop`
  # followed by a delayed `systemctl start`.
  systemd.services = {
    systemd-networkd.stopIfChanged = false;
    # Services that are only restarted might be not able to resolve when resolved is stopped before
    systemd-resolved.stopIfChanged = false;
  };

  services.udev.extraRules = ''
    # Ignore partitions with "Required Partition" GPT partition attribute
    # On our RPis this is firmware (/boot/firmware) partition
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';
  system.stateVersion = "23.05";
}
