{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.direnv;
in {
  options = {
    profiles.direnv.enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv.enable = true;

    home.packages = with pkgs; [
      nix-direnv
    ];

    xdg.configFile."direnv/direnvrc" = {
      text = "source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc";
    };
  };
}
