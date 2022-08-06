{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    slurp # ??? To select
    swaylock # To lock session
  ];

  # TODO: check what these things do
  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    gtkUsePortal = true;
  };
}
