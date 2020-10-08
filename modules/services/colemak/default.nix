{ config, lib, pkgs, ... }:
let
  cfg = config.services.colemak;
in {
  options.services.colemak = {
    enable = lib.mkEnableOption "colemak layout";
  };

  config = lib.mkIf cfg.enable {
    environment.etc."xkb/symbols/colemak".source = ../../../data/keyboard/symbols/colemak;
  };
}
