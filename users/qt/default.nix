{ config, lib, pkgs, ... }:
let
  cfg = config.qt;
in {
  config = lib.mkIf cfg.enable {
    qt = {
      platformTheme = "gnome";
    };
  };
}
