{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.guile;
in {
  options = {
    profiles.guile.enable = mkEnableOption "guile";
  };

  config = mkIf cfg.enable {
    programs.guile = {
      enable = true;

      config = ''
        (use-modules (ice-9 readline))
        (activate-readline)
      '';
    };
  };
}
