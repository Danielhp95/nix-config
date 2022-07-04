# Syntax highlighting for most languages using ASTs
{ pkgs, dsl, ... }:
with dsl;
{
  plugins = with pkgs.vimPlugins; [
    nvim-treesitter
    playground # playground for treesitter
  ];
  lua = builtins.readFile ./treesitter.lua;
}
