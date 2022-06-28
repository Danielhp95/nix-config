{ config, lib, pkgs, ... }:

with lib;
let
  base = builtins.readFile ./sway_i3_shared.conf;
  powerOffMode = ''
    set $mode_system (l)ock, (e)xit, switch_(u)ser, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown
    bindsym $mod+0 mode "$mode_system"
    mode "$mode_system" {
        bindsym l exec --no-startup-id swaylock lock, mode "default"
        bindsym s exec --no-startup-id systemctl suspend, mode "default"
        bindsym u exec --no-startup-id i3exit switch_user, mode "default"
        bindsym e exec --no-startup-id i3exit logout, mode "default"
        bindsym h exec --no-startup-id systemctl hibernate, mode "default"
        bindsym r exec --no-startup-id systemctl reboot, mode "default"
        bindsym Shift+s exec --no-startup-id systemctl poweroff, mode "default"

        # exit system mode: "Enter" or "Escape"
        bindsym Return mode "default"
        bindsym Escape mode "default"
    }
  '';
  # TODO: screenshot mode
  # screenshotMode = ''
  #   set $mode_system (a)area, (e)all, switch_(u)ser, (s)uspend, (h)ibernate, (r)eboot, (Shift+s)hutdown

  # '';
  mod = config.wayland.windowManager.sway.config.modifier;
  # sway uses `app_id` instead of `class` for app identification
  criteriaRewrite = criteria: builtins.removeAttrs
    (criteria // {
      app_id = criteria.class;
    }) [ "class" ];
in
{
  home.packages = with pkgs; [
    # display / lockscreen
    swayidle # autolock
    wdisplays # display management
    wl-clipboard # clipboard mgmt

    # screenshots/recording
    sway-contrib.grimshot # screenshots

    brightnessctl # Controlling screen brightness
    fcitx5 # Multi-language keyboard support
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    # TODO: maybe move these to their own keyboard setting profile?
    GTK_IM_MODULE = "fcitx5";
    QT_IM_MODULE = "fcitx5";
  };

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = base + powerOffMode;
    extraOptions = [ "--unsupported-gpu" ];
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      fonts = {
        names = [ "FontAwesome 13" ];
        style = "Bold Semi-Condensed";
        size = 13.0;
      };
      #menu = ''"rofi -show-icons -modi ssh,drun,filebrowser,emoji -show drun"'';
      menu = ''"rofi -show-icons -modi drun -show drun"'';
      gaps = {
        inner = 9;
        outer = -2;
        smartGaps = true;
        smartBorders = "on";
      };
      assigns = {
        "2" = [
          { class = "Firefox$"; }
        ];
        "9" = [
          { class = "Signal"; }
          { class = "telegramdesktop"; }
          { class = "element"; }
        ];
      };
      focus.newWindow = "urgent";
      floating = {
        criteria = [
          { title = "Appointment"; class = "evolution"; }
        ];
      };
      modes = {
        resize = {
          # escape modes
          Escape = "mode default";
          Return = "mode default";
          # arrow keys resize
          Up = "resize shrink height 10 px";
          Down = "resize grow height 10 px";
          Left = "resize shrink width 10 px";
          Right = "resize grow width 10 px";
          # hjkl resize
          k = "resize shrink height 10 px";
          j = "resize grow height 10 px";
          h = "resize shrink width 10 px";
          l = "resize grow width 10 px";
        };
      };
      keybindings = mkOptionDefault ({
        # screenshots
        Print = "exec grimshot save area";
        "${mod}+Print" = "exec grimshot copy area";
        "${mod}+Shift+Print" = "exec grimshot save screen";

        # weird movement
        "${mod}+Shift+n" = "move scratchpad, scratchpad show, resize set 1912 1043, move position 4 4";

        # bind brightnessctl to function keys
        # TODO: Show brightness levels on notification
        "XF86MonBrightnessUp" = "exec brightnessctl set 5+%; notify-send 'brightness up'";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-; notify-send 'brightness down'";
        "Shift+XF86MonBrightnessDown" = "exec brightnessctl set 1%; notify-send 'brightness low'";
        "Shift+XF86MonBrightnessUp" = "exec brightnessctl set 100%; notify-send 'brightness max'";

        # Pulse Audio controls
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.alsa-utils}/bin/amixer sset Master 5%+"; #increase sound volume
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.alsa-utils}/bin/amixer sset Master 5%-"; #decrease sound volume
        "XF86AudioMute" = "exec --no-startup-id ${pkgs.alsa-utils}/bin/amixer sset Master toggle"; # mute sound

        # TODO: not working with spotify
        # Media control
        "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";
      });
      input = {
        "*" = {
          xkb_layout = "gb";
          xkb_options = "caps:escape";
        };
      };
      startup = [
        { command = "exec mako"; always = true; }
        { command = "systemctl --user restart waybar"; always = true; }
        { command = "systemctl --user restart kanshi"; always = true; }
        { command = "dbus-update-activation-environment --systemd DISPLAY"; always = true; } # Chris hack for something
        { command = "echo XHC | sudo tee /proc/acpi/wakeup"; always = true; } # RAZER BLADE 2018 usb wakeup FIX:
        { command = "tmux start-server"; always = true; }
        {
          # locks screen after 5 mins + turns off/on monitors
          always = true;
          command = ''
            exec swayidle -w \
              timeout 300 'swaylock -f' \
                timeout 300 'swaymsg "output * dpms off"' \
                  resume 'swaymsg "output * dpms on"' \
                    before-sleep 'swaylock -f'
          '';
        }
      ];
      # waybar is configured separately
      # This has to be empty to disable ugly default bar at the bottom
      bars = [ ];
    };
  };

}
