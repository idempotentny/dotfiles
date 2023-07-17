{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  imports = [./config.nix];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {
      enableXWayland = true;
      hidpiXWayland = false;
      nvidiaPatches = false;
    };
    systemdIntegration = true;
  };

  services.wlsunset = {
    enable = true;
    latitude = "52.0";
    longitude = "21.0";
    temperature = {
      day = 6200;
      night = 3750;
    };
  };
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
