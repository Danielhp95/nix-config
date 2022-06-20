# Binding glue between home manager and nixos Desktop Environments

{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "gb";
  };
  environment.systemPackages = with pkgs; [
    xorg.xeyes # To know whether a running program is X or Wayland
  ];

  xdg.portal.enable = true;
  # Maybe these last two lines are redundant. Check xdg module?
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
}
