{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./system.nix
    ./security.nix
    ./network.nix
    #  ./impermanence.nix
    ./nix.nix
    ./users.nix
  ];
}
