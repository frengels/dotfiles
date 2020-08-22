{ config, lib, pkgs, ... }:
let
  fullName = "Frederik Engels";
in

{
  users.mutableUsers = false;
  users.users.frederik = {
    isNormalUser = true;
    hashedPassword = "$6$wogUsyO4$qwcGdg4U0w4sO3sdUKnuwl9Na0rynyB7jKiCJqRWc1I0rbrZwN0OW7mT6YNOK7zFvlSF0z5WSZjffOkOACHsM1";
    home = "/home/frederik";
    description = fullName;
    extraGroups = [ "wheel" "networkmanager" "input" "video" "audio" "adbusers" ];
    shell = pkgs.fish;
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.frederik = { ... }: {

    imports = [
      ./core
      ./editor/neovim
      ./termite
      ./htop
      ./vscode
      ./direnv
      ./sway
      ./redshift
      ./gtk
      ./qt
      ./git
      ./alacritty

      ../modules/home
    ];

    programs.home-manager.enable = true;

    programs.git = {
      enable = true;
      userName = fullName;
      userEmail = "frederik.engels92@gmail.com";
    };

    programs.neovim.enable = true;
    programs.termite.enable = true;
    programs.htop.enable = true;
    programs.vscode.enable = true;
    programs.direnv.enable = true;
    wayland.windowManager.sway.enable = true;
    services.redshift.enable = true;
    services.lorri.enable = true;
    gtk.enable = true;
    programs.alacritty.enable = true;
    programs.guile.enable = true;
  };
}
