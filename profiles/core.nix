{ config, lib, pkgs, ... }:
{
  # figure out how I get access to inputs
  environment.systemPackages = with pkgs; [
    ripgrep
  ];
}
