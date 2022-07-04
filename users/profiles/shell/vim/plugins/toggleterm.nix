# Toggle NVIM terminal nicely with good UX
{ pkgs, dsl, ... }:
with dsl;
let
  cmd = command: desc: [ "<cmd>${command}<cr>" desc ];
in
{
  plugins = with pkgs.vimPlugins; [
    toggleterm-nvim
  ];
  # add in terminal mapping to close Term
  #tnoremap."<C-Space>" = "<C-\\\\><C-n> :ToggleTerm<cr>";
  #_internal.which-key.run = {
  #  "['<C-Space>']" = cmd "ToggleTerm" "Toggle Term";
  #};
  use.toggleterm.setup = callWith {
    direction = "float";
    shade_terminals = true;
    shading_factor = 2;
    start_in_insert = true;
    persist_size = true;
    persist_mode = true;
    float_opts = {
      border = "double";
      winblend = 3;
    };
  };
  vimscript = ''
    autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-Space> <Cmd>exe v:count1 . "ToggleTerm"<CR>

    " By applying the mappings this way you can pass a count to your
    " mapping to open a specific window.
    " For example: 2<C-Space> will open terminal 2
    nnoremap <silent><c-Space> <Cmd>exe v:count1 . "ToggleTerm"<CR>
    inoremap <silent><c-Space> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
  '';
}
