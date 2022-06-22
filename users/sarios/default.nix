{ config, pkgs, profiles, ... }:

{
  home-manager.users.sarios = { profiles, ... }: {
    imports = with profiles; [
      git
      direnv
      shell.zsh
      shell.starship
      shell.vim.neovim
      desktop.sway
      desktop.swaylock
      desktop.sound
      obsidian
      waybar
      mako
    ];
    home.packages = with pkgs; [
      firefox
      tmux
      kitty
      alacritty
      bottom
      tdesktop
      exa
      bat
      delta
      element-desktop
    ];

  };
  environment.pathsToLink = [ "/share/zsh" ];
  users.users.sarios = {
    isNormalUser = true;
    hashedPassword = "$6$FSsxxOy7h3MFBXy4$wJ8fHywHWLDX30M7MFReqUUKOkDVuDWfAUbzMG6hf/z4siwpLavvzWFTly3Dp0duvlbEAJSXd2vPF.Ni7HRyp.";
    extraGroups = [
      "wheel" # For sudo users
      "plugdev" # Razer keyboard
    ];
    shell = pkgs.zsh;
  };
}
