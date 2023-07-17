{
  inputs,
  pkgs,
  config,
  lib,
  self,
  ...
}: {
  config.home.stateVersion = "23.11";
  config.home.extraOutputsToInstall = ["doc" "devdoc"];
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
    #inputs.impermanence.nixosModules.home-manager.impermanence
    ./packages.nix
    #./impermanence.nix
    ./shell
    ./hyprland
    ./term
    ./waybar
    ./anyrun
    ./editors/helix
    ./librewolf
    ./zathura
  ];
}
