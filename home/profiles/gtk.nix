{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.gtk;
in {
  options = {
    profiles.gtk.enable = mkEnableOption "gtk";
  };
  
  config = mkIf cfg.enable {
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

      gtk3 = {
        extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
    };
  };
}
