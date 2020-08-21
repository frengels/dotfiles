{ config, lib, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  environment.etc."NetworkManager/system-connections/karola-devolo.nmconnection" = {
    source = ../../../secrets/wireless/karola-devolo;
    mode = "0400";
  };

  environment.etc."NetworkManager/system-connections/karola-fritzbox.nmconnection" = {
    source = ../../../secrets/wireless/karola-fritzbox;
    mode = "0400";
  };
}
