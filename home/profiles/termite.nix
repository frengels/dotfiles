{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.termite;
in {
  options = {
    profiles.termite.enable = mkEnableOption "termite";
  };

  config = mkIf cfg.enable {
    programs.termite = {
      enable = true;

      allowBold = true;
      audibleBell = false;
      clickableUrl = true;
      font = "Fira Mono 11";
      browser = "${pkgs.xdg_utils}/bin/xdg-open";
      backgroundColor = "rgba(48, 48, 48, 1.0)";
      cursorBlink = "system";
      scrollbackLines = 10000;
    };

    home.packages = with pkgs; [
      fira-mono
      xdg_utils
    ];
  };
}
