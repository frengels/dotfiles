{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.gdb;
in {
  options = {
    programs.gdb = {
      enable = mkEnableOption "gdb";

      package = mkOption {
        type = types.package;
        default = pkgs.gdb;
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
	default = [];
	description = "Extra packages required for the configuration";
      };

      config = mkOption {
        type = types.lines;
	default = "";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ] ++ cfg.extraPackages;

    home.file.".gdbinit" = mkIf (cfg.config != "") {
      text = cfg.config;
    };
  };
}
