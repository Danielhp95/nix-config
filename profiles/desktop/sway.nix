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
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}
