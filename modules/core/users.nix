{
  config,
  pkgs,
  ...
}: {
  programs.fish.enable = true;
  users = {
    mutableUsers = true; # wip
    users = {
      admin = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "audio"
          "video"
          "input"
          "networkmanager"
          "power"
          "nix"
          "lp"
        ];
        uid = 1000;
        shell = pkgs.fish;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    neovim
    graphene-hardened-malloc
  ];
}
