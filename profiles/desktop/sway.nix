{ pkgs, ... }:
{
  # TODO: check what these things do
  security.pam.services.swaylock = { };
  environment.systemPackages = with pkgs; [
    slurp     # ??? To select
    swaylock  # To lock session
  ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    gtkUsePortal = true;
  };
}
