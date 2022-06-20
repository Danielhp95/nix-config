{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = lspkind-nvim; # symbols for classes,funcs etc.
      type = "lua";
      config = builtins.readFile ./lspkind.lua;
    }
  ];
}
