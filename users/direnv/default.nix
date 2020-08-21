{ config, lib, pkgs, ... }:
let
  cfg = config.programs.direnv;
in {
  config = lib.mkIf cfg.enable {
    programs.direnv = {
    };

    xdg.configFile."direnv/direnvrc" = {
      text = "source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc";
    };
  };
}
