{ config, pkgs, lib, ... }:
{
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    #extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    #kernelModules = [ "wl" ];
    #initrd.kernelModules = [ "wl" ];
    supportedFilesystems = [ "ntfs" ];
  };

  networking = {
    hostName = "G513IE";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };

  time = {
    timeZone = "Asia/Kolkata";
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
      mpd.serviceConfig.SupplementaryGroups = [ "pipewire" ];
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZON_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      options = "--delete-older-than 15d";
    };
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  

  hardware = {
    #enableRedistributableFirmware = true;

    pulseaudio.enable = false;

    # Graphics thing
    # opengl = {
    #  enable = true;
    #  driSupport = true;
    #  driSupport32Bit = true;
    #};

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = true;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:06:00:0";
        nvidiaBusId = "PCI:01:00:0";
      };

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
  
  };

  powerManagement.enable = true;

  services = {
#     logind.lidSwitch = "ignore";
    openssh.enable = true;

#    udev.extraRules = ''
#      ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"
#    '';

    blueman.enable = true;

    xserver = {
      enable = true;
      # Load nvidia driver for X11 and Wayland
      videoDrivers = ["nvidia"];
      #displayManager.gdm.enable = true;
      #desktopManager.gnome.enable = true;
      # displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };
    displayManager.sddm.enable = true;

    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
    };

    asusd = {
      enable = true;
      enableUserService = true;
    };

    supergfxd.enable = false;

    # Enable CUPS to print documents.
    printing = {
      enable = true;
    };

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
      systemWide = false;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;

    flatpak.enable = true;

    syncthing = {
        enable = true;
        user = "maskin";
        dataDir = "/home/maskin/syncthing";    # Default folder for new synced folders
        configDir = "/home/maskin/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    };

    mpd = {
      enable = true;
      musicDirectory = "/home/maskin/Music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "Pipewire Output"
        }
      '';
      user = "maskin";
      startWhenNeeded = true;

      # Optional:
      # network.listenAddress = "any"; # if you want to allow non-localhost connections
      # network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

