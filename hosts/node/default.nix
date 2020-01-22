{ config, lib, pkgs, ... }:

{
  imports = [
    ../personal.nix
    ./hardware-configuration.nix

    <modules/dev>
    <modules/editors/vim.nix>
    <modules/shell/zsh.nix>

    <modules/services/ssh.nix>
    <modules/services/syncthing.nix>
  ];

  networking.hostName = "node";
  networking.networkmanager.enable = true;

  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-19.09";
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 15d";
  };

  users.users.emiller.extraGroups = [ "networkmanager" ];
}
