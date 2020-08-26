{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.fish;
in {
  options = {
    profiles.fish.enable = mkEnableOption "fish";
  };

  config = mkIf cfg.enable {
    programs.fish.enable = true;
  };
};
