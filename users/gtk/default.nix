{ config, lib, pkgs, ... }:
let
  cfg = config.gtk;
in {
  config = lib.mkIf cfg.enable {
    gtk = {
      font = {
        name = "Open Sans 11";
        package = pkgs.open-sans;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.gnome3.gnome_themes_standard;
      };

      theme = {
        name = "Adwaita";
        package = pkgs.gnome3.gnome_themes_standard;
      };
    };
  };
}
