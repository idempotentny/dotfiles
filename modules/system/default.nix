{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./services.nix
    ./bluetooth.nix
    # ./pipewire.nix
  ];
  # nixpkgs.overlays = with inputs; [nixpkgs-wayland.overlay];
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  hardware = {
    opengl = {
      enable = true;
    };
  };
}
