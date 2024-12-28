{ config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    # dotDir = "~/.config/zsh";

    shellAliases = {
      # ls = "ls --color=auto";
      ls = "eza --icons=always";
      s = "systemctl";
      ssh = "footssh";
      clrbootentries = "sudo /run/current-system/bin/switch-to-configuration switch";
      nix-install = ''nix profile install'';
      vim = "nvim";
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
}
