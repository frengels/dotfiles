{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.mpv;
in {
  options = {
    profiles.mpv.enable = mkEnableOption "mpv";
  };

  config = mkIf cfg.enable {
    programs.mpv.enable = true;
  };
}
