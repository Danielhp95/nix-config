channels: final: prev: {

  __dontExport = true; # overrides clutter up actual creations

  inherit (channels.latest)
    cachix
    dhall
    discord
    element-desktop
    rage
    nix-index
    nixpkgs-fmt
    qutebrowser
    signal-desktop
    starship
    deploy-rs
    ;

  # To have all nice tree-sitter grammars
  nvim-treesitter-all = prev.vimPlugins.nvim-treesitter.withPlugins (_: final.tree-sitter.allGrammars);
  steam = prev.steam.override { extraPkgs = prev: [ prev.libgdiplus ]; };
}
