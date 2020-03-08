# modules/themes/functional/default.nix --- functional genomics/programming

{ config, lib, pkgs, ... }: {
  imports = [ ../. ]; # Load framework for themes

  # FIXME theme.wallpaper = ./wallpaper.png;

  services.compton = {
    activeOpacity = "0.96";
    inactiveOpacity = "0.75";
    settings = {
      blur-background = true;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-kern = "7x7box";
      blur-strength = 340;
    };
  };

  services.xserver.displayManager.lightdm = {
    background = "${./wallpaper.png}";
    greeters.mini.extraConfig = ''
      text-color = "#bbc2cf"
      password-background-color = "#29323d"
      window-color = "#0b1117"
      border-color = "#0b1117"
    '';
  };

  #fonts.fonts = [ pkgs.nerdfonts ];
  my.packages = with pkgs; [
    sierra-gtk-theme
    paper-icon-theme # for rofi
  ];
  my.zsh.rc = lib.readFile ./zsh/prompt.zsh;
  my.home.home.file.".background-image".source = ./wallpaper.png;
  my.home.xdg.configFile = {
    "bspwm/rc.d/polybar".source = ./polybar/run.sh;
    "bspwm/rc.d/theme".source = ./bspwmrc;
    "dunst/dunstrc".source = ./dunstrc;
    "polybar" = {
      source = ./polybar;
      recursive = true;
    };
    "rofi/theme" = {
      source = ./rofi;
      recursive = true;
    };
    "tmux/theme".source = ./tmux.conf;
    "xtheme/90-theme".source = ./Xresources;
    # GTK
    "gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Sierra-compact-dark
      gtk-icon-theme-name=Paper
      gtk-fallback-icon-theme=gnome
      gtk-application-prefer-dark-theme=true
      gtk-cursor-theme-name=Paper
      gtk-xft-hinting=1
      gtk-xft-hintstyle=hintfull
      gtk-xft-rgba=none
    '';
    # GTK2 global theme (widget and icon theme)
    "gtk-2.0/gtkrc".text = ''
      gtk-theme-name="Sierra-compact-dark"
      gtk-icon-theme-name="Paper-Mono-Dark"
      gtk-font-name="Sans 10"
    '';
    # QT4/5 global theme
    "Trolltech.conf".text = ''
      [Qt]
        style=Sierra-compact-dark
    '';
  };
}
