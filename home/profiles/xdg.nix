{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.xdg;
in {
  options = {
    profiles.xdg.enable = mkEnableOption "xdg";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-user-dirs
      xdg_utils
    ];

    xdg = {
      enable = true;
      #cacheHome = "~/.cache";
      #configHome = ~/.config;
      #dataHome = "~/.local/share";
      mime.enable = true;

      mimeApps = {
        enable = true;
        associations = {
          added = {};
          removed = {};
        };
        defaultApplications = {};
      };

      userDirs = {
        enable = true;
        desktop = "\$HOME/Desktop";
        documents = "\$HOME/Documents";
        download = "\$HOME/Downloads";
        music = "\$HOME/Music";
        pictures = "\$HOME/Pictures";
        publicShare = "\$HOME/Public";
        templates = "\$HOME/Templates";
        videos = "\$HOME/Videos";
        extraConfig = {};
      };
    };
  };
}
