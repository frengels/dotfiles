{ config, lib, pkgs, ... }:
let
  cfg = config.profiles.chromium;
in {
  options = {
    profiles.chromium.enable = lib.mkEnableOption "chromium";
  };

  config = with lib; mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      ];
    };
  };
}
