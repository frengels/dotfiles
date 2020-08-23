{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.gdb;
in {
  options = {
    profiles.gdb.enable = mkEnableOption "gdb";
  };

  config = mkIf cfg.enable {
    programs.gdb = {
      enable = true;

      config = ''
        set print pretty on

	#guile (use-modules (gdb))
      '';
    };
  };
}
