{ config, lib, pkgs, ... }:

# This is for packages that didn't require configuring and would be installed on a desktop
{
  imports = [ ../base.nix ../browser/firefox.nix ];
  environment.systemPackages = with pkgs; [
    aseprite-unfree
    # BROWSERS
    brave
    qutebrowser
    # NIX STUFF
    appimage-run
    # APPS
    atom-beta
    gnucash
    libreoffice-fresh
    keybase-gui
    calibre
    (callPackage <packages/ripcord.nix> { })
    discord
    dropbox
    gimp
    keybase-gui
    xst
    spotify
    obs-studio
    screenkey
    gnome3.nautilus
    transmission
    mpv
    okular
    pavucontrol
    rxvt_unicode
    networkmanagerapplet
    networkmanager_dmenu
    ffmpeg-full
    redshift
    # FIXME zoom-us
    # CLI
    maim
    graphviz
    dfu-programmer
  ];

  sound.enable = true;
  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };

  services = {
    xserver.enable = true;
    redshift.enable = true;
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;

    fonts = with pkgs; [
      ubuntu_font_family
      dejavu_fonts
      fira-code
      fira-code-symbols
      iosevka
      noto-fonts
      symbola
      font-awesome_5
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Ubuntu" ];
      monospace = [ "Iosevka" ];
    };
  };
}
