{ 
  pkgs, 
  ...
}: {
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-wayland;
    settings = {
      "devtools.theme" = "dark";
      "middlemouse.paste" = false;
      "privacy.resistFingerprinting.letterboxing" = true;
      "network.http.referer.XOriginPolicy" = 2;
      "browser.download.useDownloadDir" = true;
      "browser.fullscreen.autohide" = false;
      "browser.tabs.insertAfterCurrent" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.quitShortcut.disabled" = true;
    };
  };
}
