{ config, pkgs, profiles, ... }:

{
  home-manager.users.sarios = { profiles, ... }: {
    imports = with profiles; [
      git
      direnv
      shell.zsh
    ];

  };
  environment.pathsToLink = [ "/share/zsh" ];
  users.users.sarios = {
    isNormalUser = true;
    hashedPassword = "$6$FSsxxOy7h3MFBXy4$wJ8fHywHWLDX30M7MFReqUUKOkDVuDWfAUbzMG6hf/z4siwpLavvzWFTly3Dp0duvlbEAJSXd2vPF.Ni7HRyp.";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox 
      tmux kitty alacritty
      neovim vim
      bottom
      tdesktop
      exa bat delta
    ];
  };
}
