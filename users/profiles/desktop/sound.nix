{ pkgs, ... }:
{
  home.packages = with pkgs; [
    helvum # Really cool UI for piping audio streams. GTK pipewire patch bay
    pavucontrol # volume control
    easyeffects # audio post processing
    pamixer # CLI tool for pipewire
  ];

  services.mpris-proxy = { enable = true; };

}
