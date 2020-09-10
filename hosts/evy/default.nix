{ ... }:
{
  imports = [ 
    ./configuration.nix
    ./hardware.nix
    ./kernel.nix
    ../../profiles/nix.nix
    ../../users/frederik.nix
    ../../profiles/networking/wireless
  ];
}
