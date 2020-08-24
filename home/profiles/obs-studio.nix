{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.obs-studio;
in {
  options = {
    profiles.obs-studio.enable = mkEnableOption "obs-studio";
  };

  config = mkIf cfg.enable {
     programs.obs-studio = {
       enable = true;

       plugins = with pkgs; [
         obs-ndi
         obs-wlrobs
	 obs-v4l2sink
       ];
     };
  };
}
