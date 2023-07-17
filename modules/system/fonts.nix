{
  config,
  pkgs,
  ...
}: {
  fonts = {
    fonts = with pkgs; [
      noto-fonts-emoji
      jetbrains-mono
      lato
      (nerdfonts.override {fonts = ["FiraCode"];})
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [
          "FiraCode Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Lato" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
