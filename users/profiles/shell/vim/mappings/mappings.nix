{ dsl, pkgs, ... }:
with dsl;
let
  cmd = command: desc: [ "<cmd>${command}<cr>" desc ];
in
{
  plugins = with pkgs.vimPlugins; [
    which-key-nvim
  ];

  # When we get things working, remove to see if this is still necessary
  # Why do marks and registers not work?
  setup.which-key = callWith {};
  lua = builtins.readFile ./mappings.lua;

  # Here are aaaaall mappings!
  #lua = ''
  #  require("which-key").register({
  #    H = { "<cmd>tabp<cr>", "Previous tab" },
  #    L = { "<cmd>tabn<cr>", "Next tab" },
  #  })
  #'';
  #use.which-key.register = {
  #  "['<leader>']" = {
  #    g = {
  #      name = "+fugitive";
  #      s = cmd "Git" "Git status";
  #    };
  #    t = {
  #      name = "+telescope";
  #      f = cmd "Telescope find_files" "Search files";
  #      g = cmd "Telescope live_grep" "Live grep on working dir";
  #      F = cmd
  #        "lua require'telescope.builtin'.live_grep {default_text='function'}"
  #        "Grep for functions only";
  #      p = cmd "Telescope project" "Telescope project";
  #      t = cmd "Telescope" "Telescope default";
  #      m = cmd "Telescope keymaps" "keymaps";
  #    };
  #  };
  #};
}
