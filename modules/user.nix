{ pkgs, lib, config, ...}:
let
  cfg = config.user;
in
{
  options.user = {
    enable = lib.mkEnableOption "Enable user module.";
    
    userName = lib.mkOption {
      default = "mainuser";
      description = "Name of User";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "12345";
      description = "Main user";
      extraGroups = [ "networkmanager" "wheel" "video" ];
      packages = with pkgs; [
      #  thunderbird
      ];
      shell = pkgs.zsh;
    };
  };
}
