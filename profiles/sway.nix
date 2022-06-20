{ pkgs, ... }:
{
  security.pam.services.swaylock = { };
  environment.systemPackages = with pkgs; [
    slurp
    swaylock
    dmenu
    rofi
    wezterm
  ];
  programs.sway = {
    #enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      MOZ_ENABLE_WAYLAND=true
      XDG_CURRENT_DESKTOP=sway
      XDG_SESSION_TYPE=wayland
      SDL_VIDEODRIVER=wayland
      WLR_NO_HARDWARE_CURSORS=1
    '';
  };
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}
