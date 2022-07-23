{ config, pkgs, profiles, lib, services, ... }:

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

  # This didn't work for dual boot
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

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
    "spotify"
    "spotify-unwrapped"
    "steam"
    "steam-original"
    "steam-runtime"
  ];

  # Should probably be moved to overrides
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        libgdiplus
      ];
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  hardware.opengl.enable = true;

  networking.hostName = "sarios-blade"; # Define your hostname.
  networking.wireless.iwd.enable = true; # Enables iwctl REPL for connecting to the internet

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Keyboard settings and multi-language support
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    supportedLocales = [ "en_GB.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];
    inputMethod.enabled = "fcitx5";
    inputMethod.fcitx5.addons = with pkgs; [ fcitx5-chinese-addons fcitx5-rime fcitx5-configtool fcitx5-table-extra fcitx5-table-other ];
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # Disabling because it seems to have issue with pipewire
  # source: https://nixos.wiki/wiki/PipeWire
  # sound.enable = true;
  sound.mediaKeys.enable = true;

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    settings.General = {
      # To enable A2DP Sink (high quality)
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # -- Pulseaudio
  # hardware.pulseaudio.enable = true;
  # hardware.pulseaudio = {
  # package = pkgs.pulseaudioFull; # Use package with extra stuff
  # };

  # -- Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    media-session.config.bluez-monitor.rules = [
      {
        # Matches all cards
        matches = [{ "device.name" = "~bluez_card.*"; }];
        actions = {
          "update-props" = {
            "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
            # mSBC is not expected to work on all headset + adapter combinations.
            "bluez5.msbc-support" = true;
            # SBC-XQ is not expected to work on all headset + adapter combinations.
            "bluez5.sbc-xq-support" = true;
          };
        };
      }
      {
        matches = [
          # Matches all sources
          { "node.name" = "~bluez_input.*"; }
          # Matches all outputs
          { "node.name" = "~bluez_output.*"; }
        ];
      }
    ];
  };

  # Razer keyboard support
  hardware.openrazer.enable = true;
  hardware.openrazer.users = [ "sarios" ]; # Maybe this is repeated with "users/sarios/default.nix"

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
