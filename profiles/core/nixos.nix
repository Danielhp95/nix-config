# We combined two files here. TODO: clean up

{ config, lib, pkgs, self, ... }:

{
  # Sets nrdxp.cachix.org binary cache which just speeds up some builds
  imports = [ ../cachix ];

  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      dosfstools
      gptfdisk
      iputils
      usbutils
      utillinux

      binutils
      coreutils
      curl
      direnv
      fd
      git
      jq # Json query + colors
      manix # Man searcher for nix stuff
      moreutils
      nix-index # Used by manix
      nmap
      ripgrep
      tealdeer # Summary of man pages
    ];
  };

  fonts.fonts = with pkgs; [
    powerline-fonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Fira Code Mono" ];
    sansSerif = [ "Fira Code" ];
  };

  nix = {
    systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

    # Improve nix store disk usage
    autoOptimiseStore = true;
    optimise.automatic = true;
    allowedUsers = [ "@wheel" ];
    settings.sandbox = true;

    # Improve nix store disk usage
    gc.automatic = true;

    # Prevents impurities in builds
    useSandbox = true;

    # Give root user and wheel group special Nix privileges.
    trustedUsers = [ "root" "@wheel" ];

    # Generally useful nix option defaults
    extraOptions = ''
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      fallback = true
    '';
  };

  # For rage encryption, all hosts need a ssh key pair
  services.openssh.enable = true;
}
