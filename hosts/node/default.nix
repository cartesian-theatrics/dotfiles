{ config, lib, pkgs, ... }:

{
  imports = [
    ./.

    ./modules/editors/vim.nix

    ./modules/services/ssh.nix
    ./modules/services/syncthing.nix

    ./modules/shell/zsh.nix
  ];

  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "node";
  networking.networkmanager.enable = true;

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-19.09";
  };

  # FIXME Declare xterm-termite somehow

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 15d";
  };

  users.users.emiller.extraGroups = [ "networkmanager" ];
}