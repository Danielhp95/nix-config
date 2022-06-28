{ pkgs, ... }:

let
  tmuxConf = builtins.readFile ./tmux.conf;
in
{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    clock24 = true;
    # Start windows and panes index at 1, not 0
    baseIndex = 1;
    aggressiveResize = true;
    escapeTime = 0;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-256color";
    extraConfig = tmuxConf;
    plugins = with pkgs; [
      { plugin = tmuxPlugins.resurrect; }
      { plugin = tmuxPlugins.continuum; }
    ];
  };
}