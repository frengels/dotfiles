{ config, lib, pkgs, ... }:
with lib;
let
  cfg = profiles.feh;
in {
  options = {
    profiles.feh.enable = mkEnableOption "feh";
  };

  config = mkIf cfg.enable {
    programs.feh.enable = true;
  };
}
