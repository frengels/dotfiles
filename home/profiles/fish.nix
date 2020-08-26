{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.fish;
in {
  options = {
    profiles.fish.enable = mkEnableOption "fish";
  };

  config = mkIf cfg.enable {
    # Even though fish is already set as the user shell, this is required for
    # other programs such as direnv and lorri to automatically integrate with fish
    programs.fish.enable = true;
  };
}
