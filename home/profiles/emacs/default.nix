{ config, options, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.emacs;
in {
  options = {
    profiles.emacs = {
      enable = mkEnableOption "emacs";

      package = mkOption {
        type = types.package;
        default = pkgs.emacs;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = cfg.package;
    };
  };
}
