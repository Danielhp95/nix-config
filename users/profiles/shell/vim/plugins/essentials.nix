# Essential Configuration
{ lib, config, pkgs, dsl, ... }:
with dsl;
let
  # Quality of life shortenning
  cmd = command: description: [ "<cmd>${command}<cr>" description ];
in
{
  # For plugings that do not (yet) live in nixpkgs!
  plugins = with pkgs.vimPlugins; [
    # command discover
    which-key-nvim

    vim-oscyank # copy anywhere
    comment-nvim # Comments

    undotree # view all undo/repo operations
    # vim-unimpaired # movements options with [
    luasnip # Snippet engine
    friendly-snippets # more snippets
    # Make sure to add mapping for this

    # Dependencies
    deoplete-nvim # async operations (dependency)
    nvim-yarp # dependency for deoplete
    auto-session # Session manager
  ];

  setup.Comment = callWith { };
  lua = lib.mkBefore ''
    -- For developing purposes
    -- Prints table in nice format
    P = function(v)
      print(vim.inspect(v))
      return v
    end

    function strEmpty(s)
      return s == nil or s == ""
    end
    function getCurrDir()
      file = vim.fn.expand("%")
      if strEmpty(file) then
        return vim.fn.getcwd()
      else
        return vim.fn.system("dirname "..file):gsub("%s+", "")
      end
    end
  '';

  cmap."w!!" = "w !sudo tee > /dev/null %";
  tnoremap = {
    # NOTE: these are double escaped through nix, then lua
    # Remap escape visual mode to escape
    "<Esc>" = "<C-\\\\><C-n>";
    # Remap escape passthrough to <C-\><C-n>
    "<C-\\\\><C-n>" = "<Esc>";
    "<C-Space>" = "<C-\\\\><C-n> :ToggleTerm<cr>";
  };

  # use.which-key.register = dsl.callWith (lib.foldl' lib.recursiveUpdate
  #   {
  #     #"['w!!']" = rawLua ''{ "<cmd>w !sudo tee > /dev/null %<cr>", "save with sudo privilege", mode = "c" }'';
  #     K = cmd "lua show_documentation()" "Get Type Information";
  #     L = rawLua ''{ "<cmd>tabn<cr>", "Go to next tab", noremap = true }'';
  #     H = rawLua ''{ "<cmd>tabp<cr>", "Go to prev tab", noremap = true }'';
  #     j = [ "gj" "Wrapped down" ];
  #     k = [ "gk" "Wrapped up" ];
  #     "[']']" = {
  #       name = "+Jump next";
  #       d = cmd "lua vim.diagnostic.goto_next()" "next diag";
  #       q = cmd "cnext" "next quickfix";
  #     };
  #     "['[']" = {
  #       name = "+Jump prev";
  #       d = cmd "lua vim.diagnostic.goto_prev()" "prev diag";
  #       q = cmd "cprev" "prev quickfix";
  #     };
  #     "['<leader>']" = {
  #       name = "+leader_bindings";

  #       a = {
  #         name = "+misc commands";
  #         t = cmd "NvimTreeToggle" "Toggle NvimTree";
  #       };

  #       r = {
  #         name = "+run";
  #         c = cmd "r!" "run a command, pipe output into buffer";
  #         C = cmd "!" "run a command";
  #       };


  #       ok = cmd "WhichKey" "Start WhichKey";

  #       u = cmd "UndotreeToggle" "Toggle UndoTree";

  #       # movement
  #       #"'.'" = cmd ":<Up><CR>" "Repeat last command";
  #       j = cmd "wincmd j" "Move cursor to buffer below";
  #       k = cmd "wincmd k" "Move cursor to buffer above";
  #       l = cmd "wincmd l" "Move cursor to buffer right";
  #       h = cmd "wincmd h" "Move cursor to buffer left";
  #       J = cmd "wincmd J" "Move buffer downwards";
  #       K = cmd "wincmd K" "Move buffer upwards";
  #       L = cmd "wincmd L" "Move buffer right";
  #       H = cmd "wincmd H" "Move buffer left";


  #       w = {
  #         name = "+window operations";
  #         x = cmd "sp" "Split window horizontally";
  #         v = cmd "vs" "Split window vertically";
  #         q = cmd "q" "Close buffer";
  #         d = cmd "bd" "Delete buffer";
  #         k = cmd "bnext" "Next buffer";
  #         j = cmd "bprev" "Previous buffer";
  #         t = cmd "tabedit" "New buffer/tab";
  #         D = cmd "Bclose!" "Delete buffer aggressively";
  #       };
  #       #"gs" =
  #       #  [ "<cmd>lua require('neogit').open()<CR>" "Open neogit (magit clone)" ];
  #       #"gb" = [ "<cmd>BlamerToggle<CR>" "Toggle git blame" ];
  #       #"gc" = [ "<cmd>Neogen<CR>" "generate comments boilerplate" ];


  #       #"hs" = [ "<cmd>Gitsigns preview_hunk<CR>" "preview hunk" ];
  #       #"hn" = [ "<cmd>Gitsigns next_hunk<CR>" "next hunk" ];
  #       #"hp" = [ "<cmd>Gitsigns prev_hunk<CR>" "prev hunk" ];

  #       # CD
  #       "cg" = [ "<cmd>Gcd<CR>" "not sure" ];
  #       "cl" = [ "<cmd>lcd %:h<CR>" "change directory to current file dir" ];
  #       "ch" = [ "<cmd>cd \~<CR>" "change directory to home dir" ];
  #       "['c.']" = [ "<cmd>Cd .<CR>" "change directory to current dir" ];
  #       "['c<space>']" = [ "<cmd>Cd<space>" "something" ];

  #       i = {
  #         name = "+lsp_bindings";
  #         #ai = cmd "AnsiEsc" "Replace ansi escape codes with colors";
  #         D = cmd "lua vim.lsp.buf.declaration()" "Jump to Declaration";
  #         d = cmd "lua vim.lsp.buf.definition()" "Jump to Definition";
  #         i = cmd "lua vim.lsp.buf.implementation()" "Jump to Implementation";
  #         s = cmd "lua vim.lsp.buf.signature_help()" "Get function signature";
  #         k = cmd "lua vim.lsp.buf.type_definition()" "Get type definition";
  #         f = cmd "lua vim.lsp.buf.formatting()" "Format buffer";
  #         R = cmd "lua vim.lsp.buf.rename()" "Rename function/variable";
  #         c = cmd "lua vim.lsp.buf.code_action()" "Perform code action";
  #         r = cmd "<cmd>lua vim.lsp.buf.references()" "Get function/variable refs";
  #         e = cmd "lua vim.diagnostic.open_float()" "Get lsp errors";
  #       };
  #     };
  #   }
  #   (lib.attrValues config._internal.which-key));
  # use.which-key.setup = callWith { };

  # yoinked from gytis
  vimscript = ''
    " Function to clean trailing Spaces on save
    function! CleanExtraSpaces() "Function to clean unwanted spaces
        let save_cursor = getpos(".")
        let old_query = getreg('/')
        silent! %s/\s\+$//e
        call setpos('.', save_cursor)
        call setreg('/', old_query)
    endfun
    autocmd BufWritePre * :call CleanExtraSpaces()
    " Preserve cursor location
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  '';
}
