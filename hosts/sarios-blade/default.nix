{ config, pkgs, profiles, ... }:

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
    loader.grub = {
      #device = "/dev/nvme0n1";
      device = "nodev";
      enable = true;
      version = 2;
      useOSProber = true;
      efiSupport = true;
    };
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "sarios-blade"; # Define your hostname.
  # Pick only one of the below networking options.
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

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.root.hashedPassword = "$6$lrguFJ3Bvt21pXxl$XOPIdssQnMAIuKX6s2LTqZAdSWZwInexCE1yQvNeCRtS/r5pL0j8OLSYaT8Aimaw4/VZ6ROIXlqYI62zVzqEF1";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    xorg.xf86inputlibinput # for razer trackpad
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
