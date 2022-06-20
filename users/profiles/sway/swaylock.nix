{ config, pkgs, ... }:
let
  #colors = config.lib.base16.getColorsH "swaylock";
  #insideColor = colors.background;
  #screensaver = "~/pictures/wallpaper.jpeg";
in
{
  home.packages = with pkgs; [
    swaylock # lock screen
  ];
  # over the top configuration
  home.file.".config/swaylock/config".text = ''
    show-failed-attempts
    daemonize
    show-keyboard-layout
  '';
  /*
    home.file.".config/swaylock/config".text = with colors; ''
    show-failed-attempts
    daemonize
    show-keyboard-layout
    image=${screensaver}
    inside-color=${insideColor}
    inside-clear-color=${insideColor}
    inside-caps-lock-color=${insideColor}
    inside-ver-color=${insideColor}
    inside-wrong-color=${insideColor}
    ring-color=${primary}
    ring-clear-color=${orange}
    ring-caps-lock-color=${secondary}
    ring-ver-color=${blue}
    ring-wrong-color=${red}
    text-color=${foreground}
    layout-bg-color=${background}
    layout-border-color=${primary}
    layout-text-color${foreground}
    '';
  */
}
