{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.extraConfig = ''
    monitor=eDP-1,1920x1080@60,0x0,1
    exec-once=waybar
    exec-once=wlsunset -l 52.0 -L 21.0

    input {
        kb_layout=pl
        kb_options=caps:escape
        follow_mouse=1
        touchpad {
          natural_scroll=no
          }
        }
    general {
        sensitivity=1
        border_size=0
        gaps_in = 5
        gaps_out = 10
    }

    decoration {
        rounding=5
        blur = false
        drop_shadow = false
        blur_new_optimizations = true
    }

    misc {
        vfr = true
        disable_hyprland_logo = true
        disable_splash_rendering = true
    }

    animations {
        enabled=false
    }
    gestures {
        workspace_swipe=yes
    }
    dwindle {
        pseudotile = false
    }
    layerrule = blur, ^(gtk-layer-shell|anyrun)$
    layerrule = ignorezero, ^(gtk-layer-shell|anyrun)$

    bind=ALT,D,exec,anyrun
    bind=ALT,T,exec,alacritty
    bind=ALT,X,exec,hyprpicker | wl-copy
    bind=ALT,V,togglefloating,

    bind=ALT,left,movefocus,l
    bind=ALT,right,movefocus,r
    bind=ALT,up,movefocus,u
    bind=ALT,down,movefocus,d

    bind=ALTSHIFT,left,movewindow,l
    bind=ALTSHIFT,right,movewindow,r
    bind=ALTSHIFT,up,movewindow,u
    bind=ALTSHIFT,down,movewindow,d
    bind=ALTSHIFT,F,fullscreen,0
    bind=ALTSHIFT,Q,killactive,

    bind=ALT,1,workspace,1
    bind=ALT,2,workspace,2
    bind=ALT,3,workspace,3
    bind=ALT,4,workspace,4
    bind=ALT,5,workspace,5
    bind=ALT,6,workspace,6
    bind=ALT,7,workspace,7
    bind=ALT,8,workspace,8
    bind=ALT,9,workspace,9

    bind=ALTSHIFT,1,movetoworkspace,1
    bind=ALTSHIFT,2,movetoworkspace,2
    bind=ALTSHIFT,3,movetoworkspace,3
    bind=ALTSHIFT,4,movetoworkspace,4
    bind=ALTSHIFT,5,movetoworkspace,5
    bind=ALTSHIFT,6,movetoworkspace,6
    bind=ALTSHIFT,7,movetoworkspace,7
    bind=ALTSHIFT,8,movetoworkspace,8
    bind=ALTSHIFT,9,movetoworkspace,9

    bind=,XF86MonBrightnessUp,exec,brightnessctl set +5%
    bind=,XF86MonBrightnessDown,exec,brightnessctl set 5%-
    bind=,XF86AudioRaiseVolume,exec,pamixer -i 5
    bind=,XF86AudioLowerVolume,exec,pamixer -d 5
  '';
}
