{ pkgs, dsl, ... }:
with dsl;
let
  cmd = command: desc: [ "<cmd>${command}<cr>" desc ];
in
{
  plugins = with pkgs.vimPlugins; [
    neozoom-nvim
  ];
  # add in terminal mapping to close Term
  use.neo-zoom.setup = callWith {
    width_ratio = 0.9;
    left_ratio = 0.03;
    border = "single";
  };
}
