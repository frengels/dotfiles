{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.qt;
in {
  options = {
    profiles.qt.enable = mkEnableOption "qt";
  };

  config = lib.mkIf cfg.enable {
    qt = {
      platformTheme = "gnome";
    };
  };
}
