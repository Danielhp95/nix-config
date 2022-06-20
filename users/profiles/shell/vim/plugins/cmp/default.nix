{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-cmp;
      type = "lua";
      config = builtins.readFile ./cmp.lua;
    }
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-vsnip
    cmp-path
  ];

}
