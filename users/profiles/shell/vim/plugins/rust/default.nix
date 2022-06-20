{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = rust-tools-nvim;
      type = "lua";
      config = builtins.readFile ./rust.lua;
    }
  ];
  programs.neovim.extraPackages = with pkgs; [ rnix-lsp rust-analyzer ];
}
