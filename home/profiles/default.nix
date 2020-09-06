{ pkgs, lib, config, ... }:
{
  imports = [
    ./kitty.nix
    ./gdb.nix
    ./guile.nix
    ./git.nix
    ./alacritty.nix
    ./xdg.nix
    ./qt.nix
    ./gtk.nix
    ./redshift.nix
    ./lorri.nix
    ./direnv.nix
    ./htop.nix
    ./termite.nix
    ./sway.nix
    ./neovim.nix
    ./vscode.nix
    ./emacs
    ./chromium.nix
    ./mpv.nix
    ./feh.nix
    ./obs-studio.nix
    ./fish.nix
    ./frederik-ssh.nix
  ];
}
