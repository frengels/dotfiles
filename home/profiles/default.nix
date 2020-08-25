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
    ./emacs.nix
    ./emacs2
    ./chromium.nix
    ./mpv.nix
    ./feh.nix
    ./obs-studio.nix
  ];
}
