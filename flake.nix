{
  inputs = {
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    home.url = "github:rycee/home-manager/bqv-flakes";
    home.inputs.nixpkgs.follows = "nixpkgs";

    nix.url = "github:nixos/nix/master";
    nix.inputs.nixpkgs.follows = "nixpkgs";

    dwarffs.url = "github:edolstra/dwarffs";
    dwarffs.inputs.nixpkgs.follows = "nixpkgs";
    dwarffs.inputs.nix.follows = "nix";

    emacs.url = "github:nix-community/emacs-overlay";

    mozilla = {
      url = "github:mozilla/nixpkgs-mozilla";
      flake = false;
    };
  };

  outputs = inputs:
    let
      inherit (builtins) attrNames attrValues readDir;
      inherit (inputs.nixpkgs) lib;
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;
      inherit (utils) pathsToImportedAttrs;

      utils = import ./lib/utils.nix { inherit lib; };

      system = "x86_64-linux";

      pkgsForSystem = system:
        import inputs.nixpkgs rec {
          inherit system;
          config = { allowUnfree = true; };
          overlays = attrValues inputs.self.overlays;
        };

      pkgs = pkgsForSystem system;

    in {
      nixosConfigurations = 
        import ./hosts (recursiveUpdate inputs {
	  inherit lib system utils pkgs;
	});

      devShell."${system}" = import ./shell.nix { inherit pkgs; };

      overlay = import ./pkgs;

      overlays = let
        overlayDir = ./overlays;
        fullPath = name: overlayDir + "/${name}";
        overlayPaths = map fullPath (attrNames (readDir overlayDir));
      in pathsToImportedAttrs overlayPaths;
    };
}
