{ config, lib, pkgs, ... }:

with lib;
let font = "Pragmata Pro Mono";
in {
  options.modules.desktop.term.termite = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.desktop.term.termite.enable {
    programs.zsh.vteIntegration = true;

    my.home.xdg.configFile = {
      "gtk-3.0/gtk.css".text = ".termite {padding: 15px;}";
    };

    my.home.programs = {
      termite = {
        enable = true;
        font = "${font} 13";
        backgroundColor = "rgba(20, 21, 23, 0.9)";
        foregroundColor = "#c5c8c6";
        browser = "firefox";
        allowBold = true;
        clickableUrl = true;
        dynamicTitle = true;
        geometry = "81x20";
        mouseAutohide = true;
        colorsExtra = ''
          color0  = #141517
          color8  = #969896
          color1  = #cc6666
          color9  = #de935f
          color2  = #b5bd68
          color10 = #757d28
          color3  = #f0c674
          color11 = #f9a03f
          color4  = #81a2be
          color12 = #2a8fed
          color5  = #b294bb
          color13 = #bc77a8
          color6  = #8abeb7
          color14 = #a3685a
          color7  = #c5c8c6
          color15 = #ffffff
        '';
      };
    };
  };
}
