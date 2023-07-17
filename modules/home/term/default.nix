{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 1;
        dynamic_title = true;
        dynamic_padding = true;
        decorations = "full";
        dimensions = {
          lines = 0;
          columns = 0;
        };
        padding = {
          x = 5;
          y = 5;
        };
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      mouse = {hide_when_typing = true;};

      key_bindings = [
        {
          # clear terminal
          key = "L";
          mods = "Control";
          chars = "\\x0c";
        }
      ];
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Normal";
        };

        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };

        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };

        bold_italic = {
          family = "FiraCode Nerd Font";
          style = "Bold-Italic";
        };

        size = 18.0;

        use_think_strokes = false;
      };
      cursor.style = "Block";

      colors = {
        primary = {
          foreground = "#e0def4";
          background = "#232136";
          dim_foreground = "#908caa";
          bright_foreground = "#e0def4";
        };
        cursor = {
          text = "#e0def4";
          cursor = "#56526e";
        };
        normal = {
          black = "#393552";
          red = "#eb6f92";
          green = "#3e8fb0";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ea9a97";
          white = "#e0def4";
        };
        bright = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#3e8fb0";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ea9a97";
          white = "#e0def4";
        };
        dim = {
          black = "#6e6a86";
          red = "#eb6f92";
          green = "#3e8fb0";
          yellow = "#f6c177";
          blue = "#9ccfd8";
          magenta = "#c4a7e7";
          cyan = "#ea9a97";
          white = "#e0def4";
        };
      };
    };
  };
}
