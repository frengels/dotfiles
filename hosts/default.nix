{ lib, pkgs, system, utils, inputs, ... }:
let
  inherit (utils) recImport recImportFromDirs;
  inherit (builtins) attrValues removeAttrs;

  config = hostName:
    lib.nixosSystem {
      inherit system;

      modules =
        let
	  inherit (inputs.home.nixosModules) home-manager;
	  core = inputs.self.nixosModules.profiles.core;

	  global = {
            networking.hostName = hostName;
	    nix.nixPath = let path = toString ../.; in
	      [
	        "nixpkgs=${inputs.nixpkgs}"
		"nixos=${inputs.nixos-unstable}"
		"nixos-config=${path}/configuration.nix"
		"nixpkgs-overlay=${path}/overlays"
              ];

	    nix.registry = {
	      nixos.flake = inputs.nixos-unstable;
	      nixpkgs.flake = inputs.nixpkgs;
	      self.flake = inputs.self;
	    };

	    system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
	  };

	  overrides = {
	    systemd.package = pkgs.systemd;
          };

	  local = import "${toString ./.}/${hostName}";

	  flakeModules = attrValues (removeAttrs inputs.self.nixosModules [ "profiles" ]);

	in
	flakeModules ++ [ core global local home-manager ];
    };
  hosts = recImportFromDirs {
    dir = ./.;
    _import = config;
  };
in
hosts
