{ pkgs, ... }:

let
  config = builtins.readFile ./config;
  configRasi = builtins.readFile ./config.rasi;
  slateTheme = builtins.readFile ./slate.rasi;
in
{
  programs.rofi = {
    enable = true;
    configPath = "./config.rasi";
    theme = ./slate.rasi;
    plugins = with pkgs; [
      rofi-file-browser
      rofi-pulse-select
    ];
  };
}
