{ home, lib, pkgs, nixpkgs, nixos-unstable, self, system, utils, ... }:
let
  inherit (utils) recImport;
  inherit (builtins) attrValues removeAttrs;

  config = hostName:
    lib.nixosSystem {
      inherit system;

      modules =
        let
	  inherit (home.nixosModules) home-manager;
	  core = self.nixosModules.profiles.core;

	  global = {
            networking.hostName = hostName;
	    nix.nixPath = let path = ../.; in
	      [
	        "nixpkgs=${nixpkgs}"
		"nixos=${nixos-unstable}"
		"nixos-config=${path}/configuration.nix"
		"nixpkgs-overlay=${path}/overlays"
              ];

            nixpkgs = {
	      inherit pkgs;
	    };

	    nix.registry = {
	      nixos.flake = nixos-unstable;
	      nixpkgs.flake = nixpkgs;
	    };

	    system.configurationRevision = lib.mkIf (self ? rev) self.rev;
	  };

	  overrides = {
	    systemd.package = pkgs.systemd;
          };

	  local = import "${toString ./.}/${hostName}";

	  flakeModules = attrValues (removeAttrs self.nixosModules [ "profiles" ]);

	in
	flakeModules ++ [ core global local home-manager overrides ];
    };
  hosts = recImport {
    dir = ./.;
    _import = config;
  };
in
hosts
