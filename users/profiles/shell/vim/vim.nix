{ config, pkgs, lib, ... }:
with builtins;
with lib;
let
  base16 = config.lib.base16;
  vimColors = base16.programs.vim;
  base = readFile ./old/base_vimrc;
  mappings = readFile ./old/maps.vim;
  fzfVim = import ./old/fzf.nix pkgs;
  fugitive = import ./old/fugitive.nix pkgs;
  vimConfig = base
    + mappings
    + fzfVim.config
    + fugitive.config
    + ''
    set backupdir=~/.cache/vim
    set dir=~/.cache/vim
  '';
  colorName = "base16-${base16.theme.scheme-slug}";
  opts = config.themes.extra;
  transparent = hasAttr "opacity" opts && opts.opacity < 1;
in
{
  home.file = lib.mkIf config.themes.enable {
    ".vim/colors/${colorName}.vim".source = vimColors.template "vim";
    ".vim/autoload/airline-${colorName}.vim".source = base16.getTemplate "vim-airline-themes";
  };
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      fugitive.plugin # git operations
      vim-obsession # vim sessions
      fzfVim.plugin # fuzzy search
      ranger-vim # file navigation
      vim-airline
      vim-airline-themes
      vim-nix
      vim-oscyank
      vim-fzfpreview
    ];
    settings = {
      background = "dark";
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
    # TODO: add configuration option for wayland/x11
    extraConfig = ''
      set termguicolors

      ${optionalString config.themes.enable ''
        colorscheme ${colorName}
        " base16 color schemes don't have good support for transparent
        ${optionalString transparent "hi Normal guibg=NONE ctermbg=NONE"}
      ''}

      " airline
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#show_buffers = 0
      " very useful for nix/js
      let g:airline#extensions#tabline#formatter = 'jsformatter'

      " yank over ssh, yank anywhere!
      vnoremap <Leader>y  :OSCYank<CR>
      nnoremap <Leader>Y  v$:OSCYank<CR>
      nnoremap <Leader>yy V:OSCYank<CR>
      let g:oscyank_max_length = 100000000

    '' + vimConfig;
  };
}
