{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = telescope-project-nvim;
      type = "lua";
      config = ''
        require('telescope').setup {
          extensions = {
            project = {
              base_dirs = {
                '~/',
                '~/repos',
              },
              -- theme = "dropdown"
            }
          }
        }
        require'telescope'.load_extension('project')
        vim.api.nvim_set_keymap(
          "n",
          "<leader>tp",
          ":Telescope project<CR>",
          { noremap = true }
        )
      '';
    }
  ];
}
