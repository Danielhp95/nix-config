{ config, pkgs, profiles, ... }:

{

  imports = with profiles; [ desktop.steam ];

  home-manager.users.sarios = { profiles, ... }: {
    imports = with profiles; [
      git
      direnv
      shell.atuin
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
      discord # Chat server
      firefox # Web browser
      chromium # Web browser, in case that firefox does not work
      tmux # Terminal mutiplexer
      tdesktop # Telegram desktop
      exa # Better ls
      bat # Better cat
      delta # Git diff pager
      element-desktop # Matrix server client
      mpv # Media player
      spotify # Music music music
      feh # image viewer
      transmission-qt # Torrent client
      #deluge # Torrent client
      bottom # like htop but cooler
      libnotify # To have notify-send command
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
