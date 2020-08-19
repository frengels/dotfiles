{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    master.url = "github:NixOS/nixpkgs/master";

    home.url = "github:rycee/home-manager/bqv-flakes";
    home.inputs.nixpkgs.follows = "nixpkgs";

    nix.url = "github:nixos/nix/master";
    nix.inputs.nixpkgs.follows = "nixpkgs";

    dwarffs.url = "github:edolstra/dwarffs";
    dwarffs.inputs.nixpkgs.follows = "nixpkgs";
    dwarffs.inputs.nix.follows = "nix";

    emacs.url = "github:nix-community/emacs-overlay";

    mozilla = { url = "github:mozilla/nixpkgs-mozilla"; flake = false; };
  };

  outputs = inputs:
    let
      lib = inputs.master.lib;
    in {
      nixosConfigurations = {
        evy = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
	    ./hosts/evy/configuration.nix
	    ./hosts/evy/hardware.nix
	    ./hosts/evy/kernel.nix
	    ./profiles/nix.nix
	  ];
        };
      };
    };
}
