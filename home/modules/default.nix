{ config, lib, pkgs, ... }:
{
  imports = [
    ./programs/gdb.nix
    ./programs/guile.nix
  ];
}
