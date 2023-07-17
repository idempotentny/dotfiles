{
  pkgs,
  lib,
  inputs,
  ...
}: {
  
  programs.emacs = {
    enable = true;
  };
}
