# Tui for the login manager

{ lib, pkgs, ... }:
with lib;
let
  command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd sway";
in
{
  users.users.greeter.group = "greeter";
  users.groups.greeter = { };
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  services.xserver.displayManager.job.execCmd = "";
  systemd.services.display-manager.enable = false;
  services.greetd = {
    enable = true;
    settings = {
      # tui working
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd sway";
      };
    };
  };
}
