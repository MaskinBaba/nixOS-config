{ inputs, config, pkgs, ... }: {
  programs.ags = {
    enable = true;

    # symlink to ~/.config/ags
    # configDir = ../ags;
    configDir = ./../ags;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      # inputs.ags.packages.${pkgs.system}.battery
      fzf
      gtksourceview
      # webkitgtk
      accountsservice
      # inputs.astal.packages.${pkgs.system}.battery
    ];
  };

}
