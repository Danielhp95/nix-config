{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lutris

    # Taken from https://github.com/borisbabic/hearthstone_hdt_linux
    winetricks
    wineWowPackages.staging
  ];
}
