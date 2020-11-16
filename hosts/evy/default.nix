{ ... }:
{
  imports = [ 
    ./configuration.nix
    ./hardware.nix
    ./kernel.nix
    ../../users/frederik.nix
    ../../profiles/networking/wireless
  ];
}
