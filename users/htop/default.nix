{ config, lib, pkgs, ... }:

let
  cfg = config.programs.htop;
in {
  config = lib.mkIf cfg.enable {
    programs.htop = {
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
