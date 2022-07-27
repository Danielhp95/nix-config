# Themes + Status Line (lualine atm)
{ pkgs, dsl, ... }:
with dsl;
{
  plugins = with pkgs.vimPlugins; [
    lualine-nvim
    tabline-nvim

    # Colorschemes
    dracula-vim
    tokyonight-nvim
    nightfox-nvim
    onedarkpro-nvim
    #zephyr-nvim

    nvim-web-devicons
  ];

  setup.onedarkpro = callWith { };
  vimscript = ''
    set termguicolors
    colorscheme dracula
  '';

  # setup.tabline.show_index = false;

  setup.lualine = {
    options = {
      icons_enabled = true;
      theme = "auto";
      component_separators = { left = ""; right = ""; };
      section_separators = { left = ""; right = ""; };
      globalstatus = false;
    };
    sections = {
      lualine_a = [ "%{&spell ? 'SPELL' : ':3'}" "mode" ];
      lualine_b = [ "branch" "diff" "diagnostics" ];
      lualine_c = [ "filename" ];
      lualine_x = [ "filetype" ];
      lualine_y = [ "progress" ];
      lualine_z = [ "location" ];
    };
    inactive_sections = {
      lualine_a = [ ];
      lualine_b = [ "filetype" ];
      lualine_c = [ "filename" ];
      lualine_x = [ "location" ];
      lualine_y = [ ];
      lualine_z = [ ];
    };
    tabline = { };
    extensions = [ ];
  };
  # TODO: tabline
}
