{ config, lib, pkgs, ... }:
let
  cfg = config.programs.git;
in {
  config = lib.mkIf cfg.enable {
    programs.git = {
      package = pkgs.gitFull;
    };

    home.packages = with pkgs; [
      git-crypt
      git-secrets
    ];
  };
}
