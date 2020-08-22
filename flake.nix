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
      allSystems = [ "x86_64-linux" "i686-linux" "aarch64-linux" ];
      diffTrace = left: right: string: value: if left != right then builtins.trace string value else value;

      inherit (builtins) attrNames attrValues readDir;
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs mapAttrs;
      inherit (utils) pathsToImportedAttrs;

      config = {
        allowUnfree = true;
	android_sdk.accept_license = true;
      };

      channels = with inputs; {
        pkgs = nixos-unstable;
	modules = nixpkgs;
	lib = nixpkgs;
      };

      inherit (channels.lib) lib;

      utils = import ./lib/utils.nix { inherit lib; };

      system = "x86_64-linux";

      channelToOverlay = { system, config, flake, branch }: (final: prev: { ${flake} =
        mapAttrs (k: v: diffTrace (baseNameOf inputs.${flake}) (baseNameOf prev.path) "pkgs.${k} pinned to nixpkgs/${branch}" v)
	inputs.${flake}.legacyPackages.${system};
      });

      flakeToOverlay = { system, flake, name }: (final: prev: { ${flake} =
        mapAttrs (k: v: diffTrace (baseNameOf inputs.${flake}) (baseNameOf prev.path) "pkgs.${k} pinned to ${name}" v)
	inputs.${flake}.legacyPackages.${system};
      });

      pkgsForSystem = system: import channels.pkgs rec {
        inherit system config;

	overlays = (attrValues inputs.self.overlays) ++ [
	  (channelToOverlay { inherit system config; flake = "nixpkgs"; branch = "master"; })
	  (channelToOverlay { inherit system config; flake = "nixos-unstable"; branch = "nixos-unstable"; })
	  (import inputs.mozilla)
	  inputs.nix.overlay
	  inputs.emacs.overlay
	  inputs.self.overlay
	];
      };

      forAllSystems = f: lib.genAttrs allSystems (system: f {
        inherit system;
	pkgs = pkgsForSystem system;
      });

    in {
      nixosConfigurations =
        let
	  pkgs = pkgsForSystem system;
	in
        import ./hosts (recursiveUpdate inputs {
	  inherit lib system utils pkgs;
	});

      # devShell."${system}" = import ./shell.nix { inherit pkgs; };

      legacyPackages = forAllSystems ({ pkgs, ... }: pkgs);

      packages = forAllSystems ({ pkgs, ... }: lib.filterAttrs (_: p: (p.meta.broken or null) != true) {
      });

      overlay = import ./pkgs;

      overlays = lib.listToAttrs (map (name: {
        name = lib.removeSuffix ".nix" name;
	value = import (./overlays + "/${name}");
      }) (attrNames (readDir ./overlays)));

      nixosModules = let
        moduleList = (import ./modules/nixos.nix);
	modulesAttrs = pathsToImportedAttrs moduleList;

	profilesList = import ./profiles/list.nix;
	profilesAttrs = { profiles = pathsToImportedAttrs profilesList; };
      in
      modulesAttrs // profilesAttrs;
    };
}
