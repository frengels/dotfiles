{ config, lib, pkgs, ... }:
let
  fullName = "Frederik Engels";
in {
  users.mutableUsers = false;
  users.users.frederik = {
    isNormalUser = true;
    hashedPassword = import ../secrets/frederik/pw.nix;
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

    qt = {
      enable = true;
      platformTheme = "gnome";
    };

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
      redshift.enable = false; # redshift just gets too dark at night
      lorri.enable = true;
      direnv.enable = true;
      htop.enable = true;
      termite.enable = true;
      neovim.enable = true;
      vscode.enable = true;
      chromium.enable = true;
      mpv.enable = true;
      feh.enable = true;
      obs-studio.enable = true;
      fish.enable = true;
      frederik-ssh.enable = true;
      emacs.enable = true;
      emacs.package = pkgs.emacsGcc;
    };

    home.packages = with pkgs; [
      jetbrains.idea-community
      discord
      tdesktop
      texlive.combined.scheme-full
      libreoffice-fresh # need this for resume writing etc
      valgrind
      gimp
      poppler_utils
      zathura
      # temporarily disabled as compiling hogs resources
      # julia # testing out julia for language design
      eternal-terminal
      vulkan-tools
      wineWowPackages.unstable
      unzip
      patchelf
      kicad-unstable
      librepcb
      eagle
      anki
    ];
  };
}
