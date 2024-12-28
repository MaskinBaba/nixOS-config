{ pkgs, lib, config, ...}:
let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "Enable user module.";
    userName = lib.mkOption { default = "mainuser"; };
    description = lib.mkOption { default = "User"; };
    extraGroups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "video" ];
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
        isNormalUser = true;
        initialPassword = "12345";
        description = "${cfg.description}";
        extraGroups = cfg.extraGroups;
        packages = with pkgs; [
        #  thunderbird
        ];
        shell = pkgs.zsh;
      };
  };
}