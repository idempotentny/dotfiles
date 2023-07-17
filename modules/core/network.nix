{
  config,
  pkgs,
  lib,
  ...
}: {
  networking = {
    nameservers = ["127.0.0.1" "::1"];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager = {
      enable = true;
      dns = "none";
      unmanaged = ["rndis0"];
      wifi.macAddress = "random";
    };
    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };
  systemd.services.NetworkManager-wait-online.enable = false;
}
