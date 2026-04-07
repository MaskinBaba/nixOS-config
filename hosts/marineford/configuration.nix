{ config, lib, pkgs, inputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./sops.nix
      # ./../../modules/server/home-assistant.nix
      ./../../modules/server/immich.nix
      ./hardware-configuration.nix
    ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda"; 
  };

  networking.hostName = "marineford"; 
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = false;


  # Enable the GNOME Desktop Environment.
  services.displayManager = {
    # enable = true;
    gdm = {
      enable = false;
      autoSuspend = false;
    };
    sddm.enable = false;
  };
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.xrdp.enable = true;
  
  # Use the GNOME Wayland session
  services.xrdp.defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
  
  # XRDP needs the GNOME remote desktop backend to function
  services.gnome.gnome-remote-desktop.enable = true;
  
  # Open the default RDP port (3389)
  services.xrdp.openFirewall = true;


  # Lid
  services.upower.ignoreLid = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # nginx
  services.nginx = {
    enable = true;
    virtualHosts.localhost = {
      # locations."/" = {
      #   return = "200 '<html><body>Its working</body></html>'";
      #   extraConfig = ''
      #     default_type text/html;
      #   '';
      # };
      # listen = [ { addr = "127.0.0.1"; port = 8080; } ];
    };
  };

  environment.etc."nextcloud-admin-pass".text = "hebbememeow";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "localhost";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "sqlite";
    };
    settings = {
      trusted_domains = [
        "192.168.1.14"
        "127.0.0.1"
        "maskinscache.xyz"
        "nc.maskinscache.xyz"
        "ignat.ns.cloudflare.com"
        "rihana.ns.cloudflare.com"
      ];
    };
  };

  services.cloudflared = {
    enable = true;
    # package = "pkgs.cloudflared";
    tunnels = {
      "1cbc7afb-97ee-487a-80c0-1e74f6960f3d" = {
        credentialsFile = "/var/lib/cloudflared/1cbc7afb-97ee-487a-80c0-1e74f6960f3d.json";
        ingress = {
          "nc.maskinscache.xyz" = "http://localhost:80";
          # "nc.maskinscache.xyz" = {
          #   service = "http://localhost:80";
          #   # path = "/*.(jpg|png|css|js)";
          # };
          # "www.nc.maskinscache.xyz" = "http://localhost:80";
        };
        default = "http_status:404";
      };
    };
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "maskin";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maskin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "dialout" "video" "plugdev" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .#marineford";
    };
    # history.size = 10000;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    tmux
    wget
    git
    cloudflared
    htop
    neofetch
    neovim
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.Macs = [
      "hmac-sha2-512-etm@openssh.com"
      "hmac-sha2-256-etm@openssh.com"
      "umac-128-etm@openssh.com"
      "hmac-sha2-256"
    ];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 
    80 
    8080
    # config.services.home-assistant.config.http.server_port
   ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 15d";
      randomizedDelaySec = "20min";
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}

