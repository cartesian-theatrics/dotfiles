{ config, lib, pkgs, ... }:

with lib; {
  options.modules.shell.yubikey = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.shell.yubikey.enable {
    my = {
      packages = with pkgs; [
        gnupg
        yubikey-manager-qt
        yubikey-manager
        yubikey-personalization
      ];
    };

    services.udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];
    services.pcscd.enable = true;

    environment.shellInit = ''
      export GPG_TTY="$(tty)"
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    '';

    programs = {
      ssh.startAgent = false;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
