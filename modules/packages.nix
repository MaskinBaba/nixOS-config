{ config, pkgs, pkgs-unstable, lib, inputs, ... }:
# let
#   nixos2505 = fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-25.05.tar.gz";
# in
{
  environment.systemPackages = (with pkgs; [
    vim 
    wget
    foot
    zsh
    zsh-completions
    zsh-autosuggestions
    pciutils
    discord
    lshw
    onlyoffice-desktopeditors
    nvtopPackages.full
    htop
    neofetch
    pywal
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
    gparted
    brave
    heroic
    # lutris
    libreoffice-qt6-fresh
    gimp
    protontricks
    waybar
    dunst
    libnotify
    rofi
    wofi
    pulseaudio
    pcmanfm
    networkmanagerapplet
    playerctl
    swww
    polkit
    lxqt.lxqt-policykit
    lemurs
    pavucontrol
    grim
    slurp
    killall
    obs-studio
    xorg.xhost
    hyprlock
    hypridle
    lxappearance
    chromium
    fzf
    wl-clipboard
    git
    xdg-desktop-portal-hyprland
    mangohud
    goverlay
    kdePackages.kdeconnect-kde
    mpv
    mpvScripts.mpris
    # inputs.helix.packages."${pkgs.system}".helix
    btop
    sxiv
    zathura
    thunderbird
    vscodium
    neovim
    android-tools
    android-studio
    # davinci-resolve
    krita
    inkscape
    kdePackages.kdenlive
    ncmpcpp
    mpc
    mpd
    ags
    jdk
    python315
    fuzzel
    nwg-look
    eza
    nixd
    ntfs3g
    keepassxc
    # networkmanager
    libsixel
    ryubing
    bottles
    scrcpy
    rpi-imager
    # kicad
    vlc
    pywal
    vivaldi
    gammastep
    usbutils
    wpgtk
    xsettingsd
    shadps4
    nextcloud-client
    ollama
    kdePackages.kwallet-pam
    feishin
    rquickshare
    clipse
    glib
    freerdp
    libsForQt5.qt5ct
    kdePackages.qt6ct
    tokyonight-gtk-theme
    lxqt.pcmanfm-qt
    hyprshade
    swaynotificationcenter
    # nixos2505.jellyfin-media-player
    jellyfin-media-player
    # quickshell
    # qt6.qtwayland
    sops
    age
  ]) 
  
  ++ 
  
  (with pkgs-unstable; [
    home-manager
    lutris
  ]);
}
