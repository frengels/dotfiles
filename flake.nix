{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    master.url = "github:NixOS/nixpkgs/master";

    home.url = "github:rycee/home-manager/bqv-flakes";
    home.inputs.nixpkgs.follows = "nixpkgs";

    emacs.url = "github:nix-community/emacs-overlay";

    mozilla = { url = "github:mozilla/nixpkgs-mozilla"; flake = false; };
  };

  outputs = { self, ... }@inputs: {
    nixosConfigurations.evy = inputs.master.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
