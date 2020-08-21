{ config, lib, pkgs, ... }:
let
  cfg = config.programs.vscode;

  vscode-clangd = pkgs.vscode-utils.buildVscodeMarketplaceExtension rec {

    mktplcRef = {
      name = "vscode-clangd";
      publisher = "llvm-vs-code-extensions";
      version = "0.1.6";
      sha256 = "07bf54f19b5c9385014dfeee47015c73b6d3bac7f95db6d005f91bd5e7123c07";
    };

    buildInputs = [
      pkgs.clang-tools
    ];

    postPatch = ''
      # patch packages.json to use nix's clang
      substituteInPlace "./package.json" \
        --replace "\"default\": \"clangd\"" "\"default\": \"${pkgs.clang-tools}/bin/clangd\""
    '';

    meta = with pkgs.stdenv.lib; {
      description = "Provides C/C++ language IDE features for VS Code using clangd";
      license = licenses.mit;
    };
  };
in {
  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    programs.vscode = {
      # disable for now as it doesn't show all extensions
      # package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.Nix 
        ms-vscode.cpptools
        redhat.vscode-yaml
        ms-vscode-remote.remote-ssh
        ms-python.python
        matklad.rust-analyzer
        llvm-org.lldb-vscode
        james-yu.latex-workshop
	vscode-clangd
      ];
    };

    home.packages = with pkgs; [
      clang-tools
    ];
  };
}
