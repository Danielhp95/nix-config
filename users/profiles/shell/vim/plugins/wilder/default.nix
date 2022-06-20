{ pkgs, ... }:
{
  programs.neovim.plugins = [{
    plugin = pkgs.vimPlugins.wilder-nvim;
    type = "lua";
    config = builtins.readFile ./wilder.lua;
  }];
}
