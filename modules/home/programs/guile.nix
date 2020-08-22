{ config, lib, pkgs, ... }:
with lib;
let 
  cfg = config.programs.guile;
in {
  options = {
    programs.guile = {
      enable = mkEnableOption "guile";

      package = mkOption {
        type = types.package;
        default = pkgs.guile;
      };

      extraPackages = mkOption {
        type = types.listOf types.package;
        default = [];
      };

      config = mkOption {
        type = types.lines;
        default = "";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ] ++ cfg.extraPackages;

    home.file.".guile" = mkIf (cfg.config != "") {
      text = cfg.config;
    };
  };
}
