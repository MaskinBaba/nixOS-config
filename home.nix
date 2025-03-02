{ config, pkgs, ... }:

{
  imports = [
    ./home-manager/zsh.nix
  ];

  home.username = "maskin";
  home.homeDirectory = "/home/maskin";

  home.stateVersion = "24.05";
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    (pkgs.writeShellScriptBin "lutris-dgpu" ''
      nvidia-offload lutris
    '')
    (pkgs.writeShellScriptBin "steam-dgpu" ''
      nvidia-offload steam
    '')
    (pkgs.writeShellScriptBin "heroic-dgpu" ''
      nvidia-offload heroic
    '')
    (pkgs.writeShellScriptBin "pavufix" ''
      GSK_RENDERER=ngl pavucontrol
    '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/maskin/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    # SHELL = "zsh";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
