{ pkgs, ... }:

# Probably this can live elsewhere, but for now here it stays!
{
  home.packages = with pkgs; [
    obsidian
  ];
}
