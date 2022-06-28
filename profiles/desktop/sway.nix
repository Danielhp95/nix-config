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
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    gtkUsePortal = true;
  };
}
