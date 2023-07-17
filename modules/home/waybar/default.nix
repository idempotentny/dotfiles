{
  pkgs,
  config,
  ...
}: {
  xdg.configFile."waybar/style.css".text = import ./style.nix;
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      patchPhase = ''
        substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch workspace \" + name_; system(command.c_str());"
      '';
    });

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 7;
        exclusive = true;
        modules-left = [
          "clock"
          "wlr/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "backlight"
          "battery"
          "pulseaudio#microphone"
        ];
        "wlr/workspaces" = {
          on-click = "activate";
          all-outputs = true;
          disable-scroll = false;
          format = "{icon}";
          active-only = false;
          format-icons = {
            default = "";
            active = "";
          };
          # "persistent_workspaces" = {
          #     "1" = [];
          #     "2" = [];
          #     "3" = [];
          #     "4" = [];
          #     "5" = [];
          # };
        };
        clock = {
          format = "{:  %R    %d/%m}";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}%";
          format-charging = "";
          format-plugged = "";
          format-alt = "{capacity}%";
        };
        network = {
          format-wifi = "󰤨 ";
          format-ethernet = " 󰤨{bandwidthTotalBytes}";
          format-alt = "󰤨 {ipaddr}/{ifname}";
          format-disconnected = "󰤭";
          tooltip-format = "{ipaddr}/{ifname} via {gwaddr} ({signalStrength}%)";
        };
        pulseaudio = {
          format = "{icon} {volume}%";
          format-icons = {
            "headphone" = "";
            "headset" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
          format-muted = "";
          tooltip = false;
          on-click = "pamixer -t";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          on-click = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
          scroll-step = 5;
        };
      };
    };
  };
}
