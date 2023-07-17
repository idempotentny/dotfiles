{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  #bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  #nvidia = ../modules/nvidia;
  wayland = ../modules/system;
  hw = inputs.nixos-hardware.nixosModules;
  #ragenix = inputs.ragenix.nixosModules.age;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [
    core
    #ragenix
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.admin = ../modules/home;
  };
in {
  desktop = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "nixos";}
        ./desktop/hardware-configuration.nix
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
