{ pkgs, lib, config, ... }:
{
  imports = [
    ./programs/guile.nix
    ./programs/gdb.nix
  ];
}
