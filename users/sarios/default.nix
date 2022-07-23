{ config, pkgs, profiles, ... }:

{
  home-manager.users.sarios = { profiles, ... }: {
    imports = with profiles; [
      git
      direnv
      shell.zsh
      shell.starship
      shell.vim.neovim
      shell.tmux
      shell.kitty
      desktop.sway
      desktop.swaylock
      desktop.rofi
      desktop.zathura
      desktop.sound
      obsidian
      waybar
      mako
    ];
    home.packages = with pkgs; [
      firefox
      tmux
      alacritty
      bottom
      tdesktop
      exa
      bat
      delta
      element-desktop
      mpv
      spotify
      feh # image viewer
      deluge # Torrent client
      bottom # like htop but cooler
    ];

  };

  # To have fzf tab work on system wide commands
  environment.pathsToLink = [ "/share/zsh" ];
  users.users.sarios = {
    isNormalUser = true;
    hashedPassword = "$6$FSsxxOy7h3MFBXy4$wJ8fHywHWLDX30M7MFReqUUKOkDVuDWfAUbzMG6hf/z4siwpLavvzWFTly3Dp0duvlbEAJSXd2vPF.Ni7HRyp.";
    extraGroups = [
      "wheel" # For sudo users
      "plugdev" # Razer keyboard
      "openrazer" # require by the openrazer daemon
    ];
    shell = pkgs.zsh;
  };

  # Activate spotify as a daemons
  services.spotifyd.enable = true;
}
