{ config, lib, pkgs, ... }:
let
  cfg = config.programs.guile;
in {
  config = lib.mkIf cfg.enable {
    programs.guile = {
      config = ''
        (use-modules (ice-9 readline))
        (activate-readline)
      '';
    };
  };
}
