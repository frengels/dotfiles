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
	  inherit (inputs.dwarffs.nixosModules) dwarffs;
	  core = inputs.self.nixosModules.profiles.core;

	  global = {
            networking.hostName = hostName;
	    nix = {
	      package = pkgs.nixFlakes;
	      allowedUsers = [ "*" ];
	      trustedUsers = [ "root" "@wheel" ];

              extraOptions = ''
                show-trace = true
                builder-use-substitutes = true
                experimental-features = nix-command flakes ca-references recursive-nix
                log-format = bar-with-logs
              '';

	      nixPath = let path = toString ../.; in
	        [
	          "nixpkgs=${inputs.self}"
	          "nixos=${inputs.nixos-unstable-small}"
	          "nixos-config=${path}/configuration.nix"
	          "nixpkgs-overlay=${path}/overlays"
                ];

              registry = lib.mapAttrs (id: flake: {
                inherit flake;
	        from = { inherit id; type = "indirect"; };
	      }) inputs;

	      useSandbox = true;

              binaryCachePublicKeys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="

                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
	      ];
 
              binaryCaches = [
                "https://cache.nixos.org"
                "https://nixpkgs-wayland.cachix.org"
		"https://nix-community.cachix.org"
	      ];

	    };

	    nixpkgs = {
	      inherit pkgs;
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
