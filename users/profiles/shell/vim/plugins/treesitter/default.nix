{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
      type = "lua";
      config = builtins.readFile ./treesitter.lua;
    }
  ];
}
