{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.redshift;
in {
  options = {
    profiles.redshift.enable = mkEnableOption "redshift";
  };

  config = mkIf cfg.enable {
    services.redshift = {
      package = pkgs.redshift-wlr;
      longitude = "6.083887";
      latitude = "50.775345";
      provider = "manual";

      temperature = {
        day = 5500;
        night = 3700;
      };

      brightness = {
        day = "0.8";
        night = "0.2";
      };

      tray = false;
    };
  };
}
