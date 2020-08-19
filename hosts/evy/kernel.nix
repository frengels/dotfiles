{ config, pkgs, ... }:
{
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelParams = [ "mitigations=off" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
