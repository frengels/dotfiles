{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.htop;
in {
  options = {
    profiles.htop.enable = mkEnableOption "htop";
  };

  config = mkIf cfg.enable {
    programs.htop = {
      enable = true;

      colorScheme = 0;
      accountGuestInCpuMeter = false;
      cpuCountFromZero = true;
      delay = 15;
      detailedCpuTime = true;
      headerMargin = true;
      hideKernelThreads = true;
      hideThreads = false;
      hideUserlandThreads = true;
      highlightBaseName = true;
      highlightMegabytes = true;
      highlightThreads = true;
      shadowOtherUsers = true;
      showProgramPath = true;
      showThreadNames = true;
      treeView = true;
      updateProcessNames = true;
    };
  };
}
