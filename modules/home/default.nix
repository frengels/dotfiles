{ pkgs, lib, config, ... }:
{
  imports = [
    ./programs/guile.nix
  ];
}
