final: prev: rec {
  # keep sources this first
  sources = prev.callPackage (import ./_sources/generated.nix) { };
  # then, call packages with `final.callPackage`
  vimPlugins = prev.vimPlugins // (import ./vim/default.nix prev sources [
    "neozoom-nvim"
  ]);
}
