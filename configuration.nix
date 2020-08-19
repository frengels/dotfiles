# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
    '';
    trustedUsers = [ "frederik" ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    gtkUsePortal = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelParams = [ "mitigations=off" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  hardware.nvidiaOptimus.disable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
      intel-ocl
    ];
    extraPackages32 = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = [
      pkgs.source-code-pro
      pkgs.fira-mono
      pkgs.open-sans
    ];
    fontconfig = {
      # penultimate.enable = true;
      defaultFonts = {
        sansSerif = [ "Open Sans" ];
	monospace = [ "Fira Mono" ];
      };
    };
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.hostName = "evy";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  services.nscd.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  time.timeZone = "Europe/Berlin";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    powertop
    neovim
    home-manager
    acpi
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  services.dbus.packages = [ pkgs.gnome3.dconf ];

  # acpid is mostly handled by systemd nowadays
  services.udisks2.enable = true;
  services.upower = {
    enable = true;
    noPollBatteries = true;
    ignoreLid = false;
  };
  services.thermald.enable = true;
  services.tlp.enable = true;

  # look into ddcci (ddcci-driver) to control external monitors
  services.illum.enable = true;

  programs.light.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };
  users.users.frederik = {
    isNormalUser = true;
    home = "/home/frederik";
    description = "Frederik Engels";
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.fish;
  };

  services.fstrim.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

