{ config, lib, pkgs, ... }:
let
  fullName = "Frederik Engels";
in {
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
      ../home/modules
      ../home/profiles
    ];

    home.enableDebugInfo = false;

    programs.home-manager.enable = true;

    profiles = {
      git = {
        enable = true;
	userName = fullName;
	userEmail = "frederik.engels92@gmail.com";
      };
      xdg.enable = true;
      sway.enable = true;
      kitty.enable = true;
      gdb.enable = true;
      guile.enable = true;
      alacritty.enable = true;
      qt.enable = true;
      gtk.enable = true;
      redshift.enable = true;
      lorri.enable = true;
      direnv.enable = true;
      htop.enable = true;
      termite.enable = true;
      neovim.enable = true;
      vscode.enable = true;
      emacs.enable = true;
    };
  };
}
