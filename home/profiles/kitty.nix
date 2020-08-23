{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.kitty;
in {
  options = {
    profiles.kitty.enable = mkEnableOption "kitty";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      font = {
        name = "Fira Mono";
	package = pkgs.fira-mono;
      };

      settings = {
        bold_font = "auto";
	italic_font = "auto";
	bold_italic_font = "auto";

	font_size = "11.0";
	background = "#303030";
	foreground = "#c6c6c6";
      };
    };
  };
}
