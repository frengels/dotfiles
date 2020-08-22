{ config, lib, pkgs, ... }:
let
  cfg = config.programs.gdb;
in {
  config = lib.mkIf cfg.enable {
    programs.gdb = {
      config = ''
        set print pretty on

	#guile (use-modules (gdb))
      '';
    };
  };
}
