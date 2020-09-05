{ config, options, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.frederik-ssh;
in {
  options = {
    profiles.frederik-ssh.enable = mkEnableOption "frederik's ssh config";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      compression = true;
    };

    home.file.".ssh/id_rsa".source = ../../secrets/frederik/ssh/id_rsa;
    home.file.".ssh/id_rsa.pub".source = ../../secrets/frederik/ssh/id_rsa.pub;
  };
}
