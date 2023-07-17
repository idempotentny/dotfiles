''
  window#waybar {
    background-color: rgba(30, 30, 46, 0.7);
    border-radius: 0px;
    color: #cdd6f4;
    font-size: 16px;
    /* transition-property: background-color; */
    transition-duration: 0.5s;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #pulseaudio {
    color: #9CCFD8;
  }

  #network {
    color: #C4A7E7;
  }

  #workspaces button {
    background-color: transparent;
    /* Use box-shadow instead of border so the text isn't offset */
    color: #E0DEF4;
    padding-left: 6px;
    box-shadow: inset 0 -3px transparent;
    transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
  }

  #workspaces button:hover {
    color: #b4befe;
    box-shadow: inherit;
    text-shadow: inherit;
  }

  #workspaces button.active {
    color: #f9e2af;
    transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
  }

  #workspaces button.urgent {
    background-color: #eba0ac;
  }
  #custom-weather,

  #clock,
  #network,
  #battery,
  #backlight,
  #workspaces,
  #volume,
  #pulseaudio {
    border-radius: 15px;
    background-color: rgba(49, 50, 68, 0.8);
    padding: 0px 10px 0px 10px;
    margin: 5px 0px 5px 0px;
  }
  #pulseaudio.microphone {
    color: #cba6f7;
  }
  #clock {
    color: #8AADF4
  }
  #backlight {
    color: #f9e2af;
  }
  #battery {
    color: #B5E8E0;
  }

  #battery.warning {
    color: #EA9A97;
  }

  #battery.critical:not(.charging) {
    color: #EB6F92;
  }
  tooltip {
    font-family: 'Lato', sans-serif;
    border-radius: 15px;
    padding: 20px;
    margin: 30px;
  }
  tooltip label {
    font-family: 'Lato', sans-serif;
    padding: 20px;
  }
''
