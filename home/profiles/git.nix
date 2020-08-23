{ config, options, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.git;
in {
  options = {
    profiles.git = {
      enable = mkEnableOption "git";

      userName = options.programs.git.userName;
      userEmail = options.programs.git.userEmail;
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.gitFull;

      userName = cfg.userName;
      userEmail = cfg.userEmail;
    };

    home.packages = with pkgs; [
      git-crypt
    ];
  };
}
