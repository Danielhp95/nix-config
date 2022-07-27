{ ... }:
{
  imports = [
    ./options.nix
    ./mappings/mappings.nix
    ./plugins/essentials.nix
    ./plugins/bufferline.nix
    ./plugins/style.nix
    ./plugins/telescope
    ./plugins/cmp
    ./plugins/treesitter
    ./plugins/lspkind
    ./plugins/wilder
    ./plugins/fugitive.nix
    ./plugins/trouble
    ./plugins/dap
    ./plugins/nvim-tree.nix
    # ./plugins/telescope-hop
    ./plugins/telescope-project
    # ./plugins/fzf-vim.nix
    ./plugins/lsp.nix
    # ./plugins/toggleterm.nix
    ./plugins/neozoom.nix
    # ./plugins/fm.nix
    # ./plugins/gitlinker.nix
  ];
  withPython3 = true;
  withNodeJs = true;
}
