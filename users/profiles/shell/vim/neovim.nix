top@{ config, pkgs, self, ... }:
with builtins;
with pkgs.lib;
let
  base = readFile ./base_vimrc;
  mappings = readFile ./maps.vim;
in
{
  imports = [
    ./plugins/fugitive.nix
    ./plugins/fzf-vim.nix
    ./plugins/telescope
    ./plugins/telescope-project
    ./plugins/cmp
    #./plugins/wilder
    ./plugins/rust
    ./plugins/lspkind
    ./plugins/web-devicons
    ./plugins/treesitter
  ];
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-obsession # vim sessions
      gitsigns-nvim

      vim-nix
      vim-oscyank
      #vim-fzfpreview

      #deoplete-nvim
      nvim-lspconfig
      undotree
      vim-unimpaired
      friendly-snippets
      dracula-vim

      #playground
    ];
    extraConfig = ''

			" lua << EOF

      "   local o = vim.opt
      "   o.completeopt='menuone,noselect'; -- 'menuone,noinsert,noselect';
      "   o.grepprg='rg --vimgrep --no-heading --smart-case'
      "   o.grepformat='%f:%l:%c:%m,%f:%l:%m'

      "   require'lspconfig'.pyright.setup{}

			" EOF

    '' + base + mappings + ''
            colorscheme dracula
      			set background=dark
      			set number
      			set tabstop=2
      			set shiftwidth=2
      			set expandtab

      			set termguicolors

      			" yank over ssh, yank anywhere!
      			vnoremap <Leader>y  :OSCYank<CR>
      			nnoremap <Leader>Y  v$:OSCYank<CR>
      			nnoremap <Leader>yy V:OSCYank<CR>
      			let g:oscyank_max_length = 100000000
      		'';
    extraPackages = with pkgs; [ pyright ];
    # required by pyright
    withNodeJs = true;
  };
}
