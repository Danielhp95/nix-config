{ config, pkgs, profiles, lib, ... }:

{
  # Magically handles all function passing at the top of nix files
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      profiles.desktop.graphical
      profiles.desktop.tuigreet
      profiles.desktop.sway
      profiles.users.sarios
      profiles.core.nixos # TODO: Improve naming
    ];

  boot = {
    loader.efi = {
      canTouchEfiVariables = true;
    };
    loader.grub = {
      #device = "/dev/nvme0n1";
      device = "nodev";
      enable = true;
      version = 2;
      useOSProber = true;
      efiSupport = true;
    };
  };

  # External displays don't work, but nvidia-smi works. For now we keep neouvou
  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #     "nvidia-x11"
  #     "nvidia-settings"
  # ];
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.opengl.enable = true;

  networking.hostName = "sarios-blade"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.iwd.enable = true; # Enables iwctl REPL for connecting to the internet
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  #services.blueman.enable = true;  # GUI for bluetooth, maybe not needed?
  hardware.bluetooth.settings = {
    # To enable A2DP Sink (high quality)
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
  hardware.pulseaudio = {
    package = pkgs.pulseaudioFull; # Use package with extra stuff
  };

  # Razer keyboard support
  hardware.openrazer.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.root.hashedPassword = "$6$lrguFJ3Bvt21pXxl$XOPIdssQnMAIuKX6s2LTqZAdSWZwInexCE1yQvNeCRtS/r5pL0j8OLSYaT8Aimaw4/VZ6ROIXlqYI62zVzqEF1";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    xorg.xf86inputlibinput # for razer trackpad
    razergenie # For razer keyboard
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
