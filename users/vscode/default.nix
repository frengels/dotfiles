{ config, lib, pkgs, ... }:
let
  cfg = config.programs.vscode;
in {
  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    programs.vscode = {
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.Nix 
        ms-vscode.cpptools
        redhat.vscode-yaml
        ms-vscode-remote.remote-ssh
        ms-python.python
        matklad.rust-analyzer
        llvm-org.lldb-vscode
        james-yu.latex-workshop
      ];
    };
  };
}
