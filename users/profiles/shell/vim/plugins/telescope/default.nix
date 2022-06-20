{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    plenary-nvim
    {
      plugin = telescope-nvim;
      type = "lua";
      config = builtins.readFile ./telescope.lua;
    }
    telescope-fzf-native-nvim
    telescope-file-browser-nvim
  ];
}
