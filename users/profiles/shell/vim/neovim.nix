args@{ lib, pkgs, ... }:
{
  home.packages = [
    pkgs.gcc pkgs.gnumake  # Required for telescope-fzf-native. Ideally we will find away of defining these elsewhere

    # I assume this is where things get properly built?
    # I don't know how to define the contents of ./neovim-pkgs.nix in this file
    # So that I can pass it to pkgs.neovimBuilder
    (pkgs.neovimBuilder (import ./neovim-pkg.nix args))
  ];
}
