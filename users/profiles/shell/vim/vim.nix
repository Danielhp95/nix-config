{ config, pkgs, lib, ... }:
let
  base16 = config.lib.base16;
  shared = import ./shared.nix { inherit pkgs config; };
  vimColors = base16.programs.vim;
in
{
  home.file = lib.mkIf config.themes.enable {
    ".vim/colors/${shared.colors.name}.vim".source = vimColors.template "vim";
    ".vim/autoload/airline-${shared.colors.name}.vim".source = base16.getTemplate "vim-airline-themes";
  };
  programs.vim = {
    enable = true;
    plugins = shared.plugins;
    settings = shared.settings;
    # TODO: add configuration option for wayland/x11
    extraConfig = shared.config + ''
      " wayland wl-copy
      xnoremap "+y y:call system("wl-copy", @")<cr>
      nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', ${"''"}, 'g')<cr>p
      nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', ${"''"}, 'g')<cr>p
    '';
  };
}
