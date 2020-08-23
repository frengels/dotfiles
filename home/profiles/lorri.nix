{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.lorri;
in {
  options = {
    profiles.lorri.enable = mkEnableOption "lorri";
  };

  config = mkIf cfg.enable {
    services.lorri.enable = true;
  };
}
