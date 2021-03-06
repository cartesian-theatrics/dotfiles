{ config, options, lib, pkgs, ... }:

with lib;
let
  name = "Edmund Miller";
  maildir = "/home/emiller/.mail";
  email = "edmund.a.miller@gmail.com";
  protonmail = "edmund.a.miller@protonmail.com";
  notmuchrc = "/home/emiller/.config/notmuch/notmuchrc";
in {
  options.modules.shell.mail = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.shell.mail.enable {
    my = {
      packages = with pkgs; [ unstable.mu isync ];
      home = {
        accounts.email = {
          maildirBasePath = "${maildir}";
          accounts = {
            Gmail = {
              address = "${email}";
              userName = "${email}";
              flavor = "gmail.com";
              passwordCommand = "${pkgs.pass}/bin/pass Email/GmailApp";
              primary = true;
              # gpg.encryptByDefault = true;
              mbsync = {
                enable = true;
                create = "both";
                expunge = "both";
                patterns = [ "*" "[Gmail]*" ]; # "[Gmail]/Sent Mail" ];
              };
              realName = "${name}";
              msmtp.enable = true;
            };
            Eman = {
              address = "eman0088@gmail.com";
              userName = "eman0088@gmail.com";
              flavor = "gmail.com";
              passwordCommand = "${pkgs.pass}/bin/pass oldGmail";
              mbsync = {
                enable = true;
                create = "both";
                expunge = "both";
                patterns = [ "*" "[Gmail]*" ]; # "[Gmail]/Sent Mail" ];
              };
              realName = "${name}";
            };
            UTD = {
              address = "Edmund.Miller@utdallas.edu";
              userName = "eam150030@utdallas.edu";
              aliases = [ "eam150030@utdallas.edu" ];
              flavor = "plain";
              passwordCommand = "${pkgs.pass}/bin/pass utd";
              mbsync = {
                enable = true;
                create = "both";
                expunge = "both";
                patterns = [ "*" ];
              };
              imap = {
                host = "outlook.office365.com";
                port = 993;
                tls.enable = true;
              };
              realName = "${name}";
              msmtp.enable = true;
              smtp = {
                host = "smtp.office365.com";
                port = 587;
                tls.useStartTls = true;
              };
            };
          };
        };

        programs = {
          msmtp.enable = true;
          mbsync.enable = true;
        };

        services = {
          mbsync = {
            enable = true;
            frequency = "*:0/15";
            preExec = "${pkgs.isync}/bin/mbsync -Ha";
            postExec = "${pkgs.unstable.mu}/bin/mu index";
          };
        };
      };
    };
  };
}
