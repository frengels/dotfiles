{ config, lib, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  environment.etc."NetworkManager/system-connections/karola-devolo.nmconnection" =
    import ../../../secrets/wireless/karola-devolo.nix;

  environment.etc."NetworkManager/system-connections/karola-fritzbox.nmconnection" =
    import ../../../secrets/wireless/karola-fritzbox.nix;
}
