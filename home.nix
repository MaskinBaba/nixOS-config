{ config, pkgs, ... }:

{
  home.username = "maskin";
  home.homeDirectory = "/home/maskin";

  home.stateVersion = "24.05";
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
    EDITOR = "vim";
  };

  #programs.ags = {
  #  enable = true;

  #  # null or path, leave as null if you don't want hm to manage the config
  #  configDir = ../ags;

  #  # additional packages to add to gjs's runtime
  #  extraPackages = with pkgs; [
  #    gtksourceview
  #    webkitgtk
  #    accountsservice
  #  ];
  #};

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    # dotDir = "~/.config/zsh";

    shellAliases = {
      ls = "ls --color=auto";
      s = "systemctl";
      ssh = "footssh";
    };

    history = {
      size = 10000;
      path = "${config.xdg.cacheHome}/zsh/history";
    };

    completionInit = "
      zstyle ':completion:*' list-colors ''
      zstyle ':completion:*' menu select
    ";

    initExtra = ''
      PROMPT="%F{4}[%f%n@%m%F{4}]%f%(?..%F{9}✖ )%f%F{1}%~%f %# "
      (cat ~/.cache/wal/sequences &)
      fcd() {
        cd "$(find -type d | fzf)"
      }
      open () {
        xdg-open "$(find -type f | fzf)"
      }
      footssh() {
        if [[ $TERM = "foot" ]]; then
          TERM=linux ssh $@
        else
          ssh $@
        fi
      }
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
